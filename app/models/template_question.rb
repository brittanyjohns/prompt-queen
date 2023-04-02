class TemplateQuestion < ApplicationRecord
  belongs_to :prompt_template
  has_many :template_answers
  has_many :answers
  after_save :set_default_template_answer
  accepts_nested_attributes_for :template_answers, allow_destroy: true

  enum question_type: { single_choice: 0, multiple_choice: 1, long_answer: 2, number_select: 3 }

  def self.question_type_select
    question_types.keys.map { |k| [k.titleize, k] }
  end

  def set_default_template_answer
    return unless question_type === "long_answer" && template_answers.count === 0
    self.template_answers.create(name: "long answer", answer_type: "single_text")
  end

  def element_count?
    name === "ELEMENT_COUNT"
  end

  def size_type?
    name === "SIZE"
  end
end
