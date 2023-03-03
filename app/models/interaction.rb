class Interaction < ApplicationRecord
  has_many :questions, dependent: :destroy
  accepts_nested_attributes_for :questions, allow_destroy: true

  enum interaction_type: { image: 0, text: 1, other: 2 }

  def self.interaction_type_select
    interaction_types.keys.map { |k| [k.titleize, k] }
  end
end
