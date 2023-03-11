require "dry-initializer"

class OpenaiPrompt
  extend Dry::Initializer

  URL = "https://api.openai.com/v1/completions"
  IMG_URL = "https://api.openai.com/v1/images/generations"

  param :prompt

  option :model, default: proc { "text-davinci-003" }
  option :max_tokens, default: proc { 1000 }
  option :temperature, default: proc { 0 }
  option :size, default: proc { "256x256" }
  option :num_of_images, default: proc { 2 }

  def call
    connection =
      Faraday.new do |faraday|
        # faraday.ssl[:verify] = false
        faraday.headers = headers
      end
    response = connection.post(URL, body)
    json = JSON.parse(response.body)
    puts "CALL: #{response.body}"
    json["choices"].first["text"]
  end

  def call_img
    connection =
      Faraday.new do |faraday|
        # faraday.ssl[:verify] = false
        faraday.headers = headers
      end
    response = connection.post(IMG_URL, img_body)
    json = JSON.parse(response.body)
    puts "JSON IMAG URL: #{response.body}"
    json["data"].first["url"]
  end

  def call_imgs
    connection =
      Faraday.new do |faraday|
        # faraday.ssl[:verify] = false
        faraday.headers = headers
      end
    response = connection.post(IMG_URL, img_body)
    json = JSON.parse(response.body)
    puts "JSON IMAG URL: #{response.body}"
    result = []
    json["data"].each do |item|
      puts "item['url']: #{item["url"]}"
      result << item["url"]
    end
    result
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

  def img_body
    {
      prompt: prompt,
      n: num_of_images,
      size: size,
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
