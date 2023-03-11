class PromptsController < ApplicationController
  before_action :set_prompt_template, except: :show
  before_action :set_prompt, except: %i[ index new create ]

  # GET /prompts or /prompts.json
  def index
    @prompt_template = PromptTemplate.includes(questions: :answers).find(params[:prompt_template_id])
    @prompts = @prompt_template.prompts.all
  end

  # GET /prompts/1 or /prompts/1.json
  def show
    @prompt_template = PromptTemplate.includes(questions: :answers).find(params[:prompt_template_id])
    @prompt = @prompt_template.prompts.find(params[:id])
  end

  # GET /prompts/new
  def new
    @prompt = @prompt_template.prompts.new
  end

  # GET /prompts/1/edit
  def edit
  end

  # POST /prompts or /prompts.json
  def create
    @prompt = @prompt_template.prompts.new(prompt_params)

    respond_to do |format|
      if @prompt.save
        format.html { redirect_to prompt_template_url(@prompt_template), notice: "Prompt was successfully created." }
        format.json { render :show, status: :created, location: @prompt }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @prompt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prompts/1 or /prompts/1.json
  def update
    respond_to do |format|
      if @prompt.update(prompt_params)
        format.html { redirect_to prompt_template_prompt_url(@prompt_template, @prompt), notice: "Prompt was successfully updated." }
        format.json { render :show, status: :ok, location: @prompt }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @prompt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prompts/1 or /prompts/1.json
  def destroy
    @prompt.destroy!

    respond_to do |format|
      format.html { redirect_to prompt_template_prompts_url(@prompt_template), notice: "Prompt was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def prompt_text
    if @prompt.body && !@prompt.body.empty?
      response_title = @prompt_template.name + "-text"
      openai_prompt = OpenaiPrompt.new(@prompt.body)
      ai_response = openai_prompt.call
      @response = @prompt.responses.create(title: response_title, prompt_text: @prompt.body, body: ai_response)

      ActionText::RichText.create!(record_type: "Response", record_id: @response.id, name: "content", body: "<p>#{ai_response}</p>")
    end

    respond_to do |format|
      if @prompt.update(prompt_params)
        format.html { redirect_to prompt_template_prompt_url(@prompt_template, @prompt), notice: "Prompt was successfully updated." }
        format.json { render :show, status: :ok, location: @prompt }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @prompt.errors, status: :unprocessable_entity }
      end
    end
  end

  def prompt_images
    puts "\n\n#{params}\n"

    if @prompt.body && !@prompt.body.empty?
      response_title = @prompt_template.name + "-images"
      opts = { size: @prompt.image_size, num_of_images: @prompt.element_count }
      puts "opts #{opts}"
      openai_prompt = OpenaiPrompt.new(@prompt.body, opts)
      images = openai_prompt.call_imgs
      @response = @prompt.responses.create(title: response_title, prompt_text: @prompt.body, body: images.to_s)
      content = ""
      images.each_with_index do |img, i|
        content += "<img src='#{img}' class='ai_img' id='ai_img_#{@response.id}_#{i}'></img>"
      end

      ActionText::RichText.create!(record_type: "Response", record_id: @response.id, name: "content", body: content)
    end

    respond_to do |format|
      if @prompt.update(prompt_params)
        format.html { redirect_to prompt_template_prompt_url(@prompt_template, @prompt), notice: "Prompt was successfully updated." }
        format.json { render :show, status: :ok, location: @prompt }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @prompt.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_prompt_template
    @prompt_template = PromptTemplate.find(params[:prompt_template_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_prompt
    @prompt = Prompt.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def prompt_params
    params.require(:prompt).permit(:prompt_template_id, :body, :created_by, template_answers: {})
  end
end
