# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_03_24_221539) do
  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "answers", force: :cascade do |t|
    t.integer "prompt_id", null: false
    t.integer "template_question_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "answer_type"
    t.index ["prompt_id"], name: "index_answers_on_prompt_id"
    t.index ["template_question_id"], name: "index_answers_on_template_question_id"
  end

  create_table "docs", force: :cascade do |t|
    t.string "name"
    t.string "doc_type"
    t.text "body"
    t.text "raw_body"
    t.string "documentable_type", null: false
    t.integer "documentable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["documentable_type", "documentable_id"], name: "index_doc_on_documentable"
  end

  create_table "prompt_templates", force: :cascade do |t|
    t.integer "prompt_template_type"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "prefix_text"
  end

  create_table "prompts", force: :cascade do |t|
    t.integer "prompt_template_id", null: false
    t.text "body"
    t.integer "created_by"
    t.datetime "sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "element_count"
    t.string "image_size"
    t.index ["prompt_template_id"], name: "index_prompts_on_prompt_template_id"
  end

  create_table "questions", force: :cascade do |t|
    t.integer "prompt__id", null: false
    t.string "name"
    t.integer "question_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "display_name"
    t.index ["prompt__id"], name: "index_questions_on_prompt__id"
  end

  create_table "responses", force: :cascade do |t|
    t.integer "prompt_id", null: false
    t.string "created_by"
    t.text "prompt_text"
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prompt_id"], name: "index_responses_on_prompt_id"
  end

  create_table "template_answers", force: :cascade do |t|
    t.integer "template_question_id", null: false
    t.string "name"
    t.string "answer_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["template_question_id"], name: "index_template_answers_on_template_question_id"
  end

  create_table "template_questions", force: :cascade do |t|
    t.integer "prompt_template_id", null: false
    t.string "name"
    t.integer "question_type"
    t.string "display_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prompt_template_id"], name: "index_template_questions_on_prompt_template_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "answers", "prompts"
  add_foreign_key "answers", "template_questions"
  add_foreign_key "prompts", "prompt_templates"
  add_foreign_key "questions", "prompt_s"
  add_foreign_key "responses", "prompts"
  add_foreign_key "template_answers", "template_questions"
  add_foreign_key "template_questions", "prompt_templates"
end
