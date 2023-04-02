class TemplateAnswer < ApplicationRecord
  belongs_to :template_question
  delegate :prompt_template, to: :template_question
end
