class PromptTemplate < ApplicationRecord
  has_many :questions, dependent: :destroy
  accepts_nested_attributes_for :questions, allow_destroy: true

  enum prompt_template_type: { image: 0, text: 1, other: 2 }

  def self.prompt_template_type_select
    prompt_template_types.keys.map { |k| [k.titleize, k] }
  end
end
