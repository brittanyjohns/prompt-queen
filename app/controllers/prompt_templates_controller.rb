class PromptTemplatesController < ApplicationController
  before_action :set_prompt_template, only: %i[ show edit update destroy ]

  # GET /prompt_templates or /prompt_templates.json
  def index
    @prompt_templates = PromptTemplate.includes(:prompts, :responses).all
  end

  # GET /prompt_templates/1 or /prompt_templates/1.json
  def show
    @prompt = @prompt_template.prompts.new
  end

  # GET /prompt_templates/new
  def new
    @prompt_template = PromptTemplate.new
    @prompt_template.template_questions.build
  end

  # GET /prompt_templates/1/edit
  def edit
  end

  # POST /prompt_templates or /prompt_templates.json
  def create
    puts "prompt_template_params: #{prompt_template_params}"
    @prompt_template = PromptTemplate.new(prompt_template_params)

    respond_to do |format|
      if @prompt_template.save
        format.html { redirect_to prompt_template_url(@prompt_template), notice: "Template was successfully created." }
        format.json { render :show, status: :created, location: @prompt_template }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @prompt_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prompt_templates/1 or /prompt_templates/1.json
  def update
    questions = prompt_template_params["template_questions_attributes"]

    questions.each do |question|
      puts "q: #{question}"
    end

    respond_to do |format|
      if @prompt_template.update(prompt_template_params)
        format.html { redirect_to prompt_template_url(@prompt_template), notice: "Template was successfully updated." }
        format.json { render :show, status: :ok, location: @prompt_template }
      else
        pp @prompt_template.errors.inspect
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @prompt_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prompt_templates/1 or /prompt_templates/1.json
  def destroy
    @prompt_template.destroy!

    respond_to do |format|
      format.html { redirect_to prompt_templates_url, notice: "Template was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_prompt_template
    @prompt_template = PromptTemplate.includes(:template_questions, :prompts).find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def prompt_template_params
    params.require(:prompt_template).permit(:name, :prompt_template_type, :prefix_text,
                                            template_questions_attributes: [
                                              :_destroy,
                                              :id,
                                              :question_type,
                                              :name,
                                              :display_name,
                                              template_answers_attributes: [:_destroy, :id, :name, :answer_type],
                                            ])
  end
end
