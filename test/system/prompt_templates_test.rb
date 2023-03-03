require "application_system_test_case"

class TemplatesTest < ApplicationSystemTestCase
  setup do
    @prompt_template = prompt_templates(:one)
  end

  test "visiting the index" do
    visit prompt_templates_url
    assert_selector "h1", text: "Templates"
  end

  test "should create prompt_template" do
    visit prompt_templates_url
    click_on "New prompt_template"

    fill_in "Name", with: @prompt_template.name
    fill_in "Type", with: @prompt_template.type
    fill_in "User", with: @prompt_template.user_id
    click_on "Create Template"

    assert_text "Template was successfully created"
    click_on "Back"
  end

  test "should update Template" do
    visit prompt_template_url(@prompt_template)
    click_on "Edit this prompt_template", match: :first

    fill_in "Name", with: @prompt_template.name
    fill_in "Type", with: @prompt_template.type
    fill_in "User", with: @prompt_template.user_id
    click_on "Update Template"

    assert_text "Template was successfully updated"
    click_on "Back"
  end

  test "should destroy Template" do
    visit prompt_template_url(@prompt_template)
    click_on "Destroy this prompt_template", match: :first

    assert_text "Template was successfully destroyed"
  end
end
