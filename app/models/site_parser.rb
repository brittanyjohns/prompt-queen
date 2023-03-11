require "dry-initializer"
require "poppler"

class SiteParser
  extend Dry::Initializer

  # URL = "https://api.openai.com/v1/completions"
  # IMG_URL = "https://api.openai.com/v1/images/generations"

  param :path_to_pdf

  # option :model, default: proc { "text-davinci-003" }
  # option :max_tokens, default: proc { 1000 }
  # option :temperature, default: proc { 0 }
  # option :size, default: proc { "256x256" }
  # option :num_of_images, default: proc { 2 }

  def call
    document = Poppler::Document.new(path_to_pdf)

    raw_content = document.map { |page| page.find_text_raw }.join
    puts "DOC => #{raw_content}"

    raw_content
  end

  private

  def body
    {
      model: model,
      prompt: prompt,
      max_tokens: max_tokens,
      temperature: temperature,
    }.to_json
  end

  def headers
    {
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{ENV["OPENAI_ACCESS_TOKEN"]}",
      "OpenAI-Organization" => ENV["OPENAI_ORGANIZATION_ID"],
    }
  end
end
