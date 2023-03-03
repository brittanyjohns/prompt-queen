require "test_helper"

class PromptTemplatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @prompt_template = prompt_templates(:one)
  end

  test "should get index" do
    get prompt_templates_url
    assert_response :success
  end

  test "should get new" do
    get new_prompt_template_url
    assert_response :success
  end

  test "should create prompt_template" do
    assert_difference("Template.count") do
      post prompt_templates_url, params: { prompt_template: { name: @prompt_template.name, type: @prompt_template.type, user_id: @prompt_template.user_id } }
    end

    assert_redirected_to prompt_template_url(Template.last)
  end

  test "should show prompt_template" do
    get prompt_template_url(@prompt_template)
    assert_response :success
  end

  test "should get edit" do
    get edit_prompt_template_url(@prompt_template)
    assert_response :success
  end

  test "should update prompt_template" do
    patch prompt_template_url(@prompt_template), params: { prompt_template: { name: @prompt_template.name, type: @prompt_template.type, user_id: @prompt_template.user_id } }
    assert_redirected_to prompt_template_url(@prompt_template)
  end

  test "should destroy prompt_template" do
    assert_difference("Template.count", -1) do
      delete prompt_template_url(@prompt_template)
    end

    assert_redirected_to templates_url
  end
end
