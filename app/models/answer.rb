class Answer < ApplicationRecord
  belongs_to :template_question
  before_save :set_type
  enum answer_type: { single_text: 0, multiple_text: 1, number: 2 }

  def set_type
    case template_question.question_type
    when "single_choice"
      self.answer_type = "single_text"
    when "long_answer"
      self.answer_type = "single_text"
    when "multiple_choice"
      self.answer_type = "multiple_text"
    else
      text_body += "Unknown"
    end
  end

  def prompt_template
    template_question.prompt_template
  end

  def num_of_images?
    (answer_type == "multiple_text") && (prompt_template.prompt_template_type == "image")
  end

  def image_size?
    (answer_type == "single_text") && (prompt_template.prompt_template_type == "image") && (name.include?("x"))
  end

  def print_info
    text_body = ""

    case template_question.question_type
    when "single_choice"
      text_body += q.name.gsub("#ANSWER#", name)
    when "long_answer"
      text_body += q.name.gsub("#ANSWER#", name)
    when "multiple_choice"
      text_body += q.name.gsub("#ANSWER#", q.answers.map(&:name).join(","))
    when "number_select"
      name
    else
      text_body += "Unknown"
    end
    puts text_body
    text_body
  end
end
