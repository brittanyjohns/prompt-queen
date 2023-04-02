class PromptTemplate < ApplicationRecord
  has_many :template_questions, dependent: :destroy
  has_many :template_answers, dependent: :destroy
  has_many :prompts, dependent: :destroy
  has_many :responses, through: :prompts
  accepts_nested_attributes_for :template_questions, allow_destroy: true
  accepts_nested_attributes_for :template_answers, allow_destroy: true

  enum prompt_template_type: { image: 0, text: 1, other: 2 }

  def self.prompt_template_type_select
    prompt_template_types.keys.map { |k| [k.titleize, k] }
  end
end
