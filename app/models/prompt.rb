class Prompt < ApplicationRecord
  belongs_to :prompt_template
  before_save :save_choices, :set_body

  def multiple_choice_answers(id)
    return [] if template_answers[id.to_s].nil?
    template_answers[id.to_s].map(&:to_i)
  end

  def questions
    prompt_template.questions.find(template_answers.keys)
  end

  def answers
    return Answer.none unless template_answers
    Answer.find(template_answers.values)
  end

  def set_body
    return if body
    text_body = ""

    answers.each do |answer|
      question_id = answer.question_id
      q = Question.find(question_id)
      case q.question_type
      when "single_choice"
        text_body += q.name.gsub("#ANSWER#", answer.name)
      when "long_answer"
        text_body += q.name.gsub("#ANSWER#", answer.name)
      when "multiple_choice"
        text_body += q.name.gsub("#ANSWER#", answers.map(&:name).join(","))
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
