class Prompt < ApplicationRecord
  belongs_to :prompt_template
  has_many :responses, dependent: :destroy
  before_save :save_choices, :set_body

  def multiple_choice_answers(id)
    return [] if template_answers[id.to_s].nil?
    template_answers[id.to_s].map(&:to_i)
  end

  def answer_choices_for(question)
    puts "question.answers: \n#{question.answers.inspect}"
    question.answers.find { |a| a.id.to_s === self.template_answers[question.id.to_s] }
  end

  def questions
    return Question.none unless template_answers
    prompt_template.questions.find(template_answers.keys)
  end

  def answers
    return Answer.none unless template_answers
    Answer.find(template_answers.values)
  end

  def image_request?
    prompt_template.prompt_template_type == "image"
  end

  def set_body
    return if body
    text_body = ""

    answers.each do |answer|
      question_id = answer.question_id
      q = Question.find(question_id)
      case q.question_type
      when "single_choice"
        if answer.image_size?
          self.image_size = answer.name
        else
          puts "single_choice for non-image request"
          text_body += q.name.gsub("#ANSWER#", answer.name)
        end
      when "long_answer"
        if image_request?
          text_body += answer.name
        else
          puts "long_answer for non-image request"
          text_body += q.name.gsub("#ANSWER#", answer.name)
        end
      when "multiple_choice"
        text_body += q.name.gsub("#ANSWER#", q.answers.map(&:name).join(","))
      when "number_select"
        if image_request?
          self.element_count = answer.name.to_i
        else
          puts "number_select for non-image request"
        end
      else
        text_body += "Unknown"
      end
    end
    self.body = text_body
  end

  def save_choices
    template_answers.each do |question_id, answer_result|
      begin
        a = prompt_template.answers.find(answer_result)
        self.template_answers[question_id] = a.id
      rescue ActiveRecord::RecordNotFound => e
        puts "Not found"
        a = Answer.create(name: answer_result, question_id: question_id)
        self.template_answers[question_id] = a.id
      end
    end
  end

  def print_q_and_a
    str = ""
    answers.each do |answer|
      answer_id = answer.id
      a = Answer.find(answer_id)
      q = a.question
      str += "#{q.question_type}| #{q.name}\n\n\n#{a.answer_type}|#{a.name}\n"
    end
    puts str
    str
  end

  def asd
    answers.each do |question_id, answer_result|
      question = questions.find { |q| q.id.to_s == question_id }
    end
  end

  def answer_text_for(question)
    case question_type
    when "short_answer"
      question.answers.find { |a| a.id.to_s == template_answers[question.id.to_s] }.name
    when "long_answer"
      ""
    when "multiple_choice"
      question.answers.select { |a| prompt.multiple_choice_answers(question.id).include?(a.id) }.each do |answer|
        answer.name
      end
    else
      "Unknown"
    end
  end
end
