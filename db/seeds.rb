# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
corp_prompt_template = PromptTemplate.create(name: "Corporate Talk")
img_prompt_template = PromptTemplate.create(name: "Gather Images")
img_prompt_template.questions.create(display_name: "How many pictures do you want to see?", name: "ELEMENT_COUNT", question_type: 3)
img_prompt_template.questions.create(display_name: "What do you want to see pictures of?", question_type: 2)
size_question = img_prompt_template.questions.create(display_name: "How big should the pictures be?", name: "SIZE", question_type: 0)
size_question.answers.create(name: "256x256")
size_question.answers.create(name: "1024x1024")