# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180210014802) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.integer  "addressable_id",   null: false
    t.string   "addressable_type", null: false
    t.string   "email"
    t.text     "address"
    t.string   "landline"
    t.string   "mobile"
    t.string   "latitude"
    t.string   "longitude"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "assets", force: :cascade do |t|
    t.string   "type"
    t.integer  "assetable_id"
    t.string   "assetable_type"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "blogs", force: :cascade do |t|
    t.string   "title"
    t.string   "author"
    t.string   "description"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "short_description"
  end

  create_table "bootsy_image_galleries", force: :cascade do |t|
    t.string   "bootsy_resource_type"
    t.integer  "bootsy_resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bootsy_images", force: :cascade do |t|
    t.string   "image_file"
    t.integer  "image_gallery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "charges", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "stripe_id"
    t.integer  "amount"
    t.string   "card_last4"
    t.string   "card_type"
    t.string   "card_exp_month"
    t.string   "card_exp_year"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["stripe_id"], name: "index_charges_on_stripe_id", unique: true, using: :btree
  end

  create_table "contact_us", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "email"
    t.string   "company_name"
    t.string   "phone"
    t.string   "website"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "content"
  end

  create_table "contactus", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "conversations", force: :cascade do |t|
    t.integer  "author_id"
    t.integer  "receiver_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "title"
    t.string   "video_link"
    t.string   "job_requirement"
    t.string   "name"
    t.integer  "folder_id"
    t.integer  "sender_id"
    t.integer  "received_id"
    t.string   "status",          default: "pending"
    t.index ["author_id"], name: "index_conversations_on_author_id", using: :btree
    t.index ["receiver_id"], name: "index_conversations_on_receiver_id", using: :btree
  end

  create_table "coupons", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "coupon_type"
    t.date     "coupon_validate_start_date"
    t.date     "coupon_validate_end_date"
    t.date     "coupon_expired_date"
    t.integer  "max_limit"
    t.string   "status"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "documents", force: :cascade do |t|
    t.string   "file"
    t.integer  "folder_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["folder_id"], name: "index_documents_on_folder_id", using: :btree
  end

  create_table "educations", force: :cascade do |t|
    t.string   "degree"
    t.string   "degree_type"
    t.string   "degree_major"
    t.string   "school_name"
    t.datetime "date_from"
    t.datetime "date_to"
    t.string   "description"
    t.integer  "user_id"
    t.integer  "student_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "date_start"
    t.string   "date_end"
    t.string   "present"
  end

  create_table "employer_profiles", force: :cascade do |t|
    t.integer  "user_id",            null: false
    t.string   "slug"
    t.string   "company_name"
    t.text     "company_descripion"
    t.string   "website"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "linkedin"
    t.string   "instagram"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "employers", force: :cascade do |t|
    t.string   "title"
    t.string   "name"
    t.integer  "user_id"
    t.string   "link"
    t.string   "description"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "category"
    t.string   "responsibility"
    t.string   "requirement"
    t.string   "work_schedule"
    t.string   "diploma"
    t.string   "written_languages"
    t.string   "spoken_languages"
    t.string   "level_of_study"
    t.string   "zip_code"
    t.datetime "start_date"
    t.string   "url"
    t.string   "image_url"
    t.string   "city"
    t.string   "state"
    t.string   "pay"
    t.string   "years_of_experience"
    t.string   "long_description"
    t.string   "facebook"
    t.string   "instagram"
    t.string   "company_website"
    t.string   "linkedin"
    t.string   "additional_link"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "status"
    t.string   "employer_status"
    t.string   "job_duration"
    t.integer  "awarded_student_id"
  end

  create_table "folders", force: :cascade do |t|
    t.string   "name"
    t.integer  "folder_id"
    t.integer  "conversation_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["conversation_id"], name: "index_folders_on_conversation_id", using: :btree
    t.index ["folder_id"], name: "index_folders_on_folder_id", using: :btree
  end

  create_table "homes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "interviews", force: :cascade do |t|
    t.string   "body"
    t.string   "title"
    t.string   "video_link"
    t.string   "job_requirement"
    t.string   "name"
    t.string   "email"
    t.integer  "user_id"
    t.integer  "conversation_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "student_id"
    t.integer  "employer_id"
    t.string   "employer_name"
    t.string   "employer_title"
    t.string   "employer_description"
    t.string   "employer_additional"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "recipient_id"
    t.integer  "sender_id"
    t.datetime "read_at"
    t.string   "action"
    t.string   "notifiable_type"
    t.integer  "notifiable_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "personal_messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.integer  "position"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["conversation_id"], name: "index_personal_messages_on_conversation_id", using: :btree
    t.index ["position"], name: "index_personal_messages_on_position", using: :btree
    t.index ["user_id"], name: "index_personal_messages_on_user_id", using: :btree
  end

  create_table "photos", force: :cascade do |t|
    t.text     "image_data"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "conversation_id"
    t.index ["conversation_id"], name: "index_photos_on_conversation_id", using: :btree
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
    t.index ["updated_at"], name: "index_sessions_on_updated_at", using: :btree
  end

  create_table "student_profiles", force: :cascade do |t|
    t.integer  "user_id",     null: false
    t.string   "slug"
    t.string   "education"
    t.text     "description"
    t.string   "location"
    t.string   "website"
    t.integer  "age"
    t.string   "phone"
    t.string   "facebook"
    t.string   "linkedin"
    t.string   "twitter"
    t.string   "instagram"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "students", force: :cascade do |t|
    t.string   "title"
    t.string   "name"
    t.integer  "user_id"
    t.string   "link"
    t.string   "description"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "category"
    t.string   "responsibility"
    t.string   "requirement"
    t.string   "salary"
    t.string   "work_schedule"
    t.string   "internship_report"
    t.string   "company_size"
    t.string   "diploma"
    t.string   "written_languages"
    t.string   "spoken_languages"
    t.string   "level_of_study"
    t.string   "zip_code"
    t.datetime "start_date"
    t.string   "url"
    t.string   "image_url"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "status"
    t.string   "student_status"
    t.string   "pay"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.string   "taggable_type"
    t.integer  "taggable_id"
    t.string   "tagger_type"
    t.integer  "tagger_id"
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context", using: :btree
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "uploads", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "user_coupons", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "coupon_id"
    t.date     "coupon_validate_start_date"
    t.date     "coupon_validate_end_date"
    t.boolean  "one_single_free_ad"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",                    null: false
    t.string   "encrypted_password",     default: "",                    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,                     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.datetime "active_at",              default: '2013-07-13 02:41:49'
    t.boolean  "is_employer"
    t.boolean  "is_student"
    t.boolean  "is_admin"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "company_name"
    t.string   "full_name"
    t.string   "postal_code"
    t.integer  "age"
    t.string   "token"
    t.string   "password_digest"
    t.string   "location"
    t.string   "website"
    t.string   "phone"
    t.string   "education"
    t.boolean  "super_admin"
    t.string   "stripe_id"
    t.string   "stripe_subscription_id"
    t.string   "card_last4"
    t.integer  "card_exp_month"
    t.integer  "card_exp_year"
    t.string   "card_type"
    t.string   "uid"
    t.string   "provider"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "linkedin"
    t.string   "instagram"
    t.string   "description"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "works", force: :cascade do |t|
    t.string   "company_name"
    t.string   "position"
    t.datetime "date_from"
    t.datetime "date_to"
    t.string   "description"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "date_start"
    t.string   "date_end"
    t.string   "present"
  end

  add_foreign_key "personal_messages", "conversations"
  add_foreign_key "personal_messages", "users"
  add_foreign_key "photos", "conversations"
end
