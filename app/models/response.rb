class Response < ApplicationRecord
  belongs_to :prompt
  has_rich_text :content
  delegate :prompt_template, to: :prompt
end
