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

ActiveRecord::Schema.define(version: 20160925201506) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "api_clients", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "secret_key"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "check_in_symptoms", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "check_in_id"
    t.uuid     "symptom_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["check_in_id", "symptom_id"], name: "index_check_in_symptoms_on_check_in_id_and_symptom_id", unique: true, using: :btree
    t.index ["check_in_id"], name: "index_check_in_symptoms_on_check_in_id", using: :btree
    t.index ["symptom_id"], name: "index_check_in_symptoms_on_symptom_id", using: :btree
  end

  create_table "check_ins", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "user_id"
    t.uuid     "weather_report_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.float    "lat"
    t.float    "lng"
    t.index ["user_id"], name: "index_check_ins_on_user_id", using: :btree
    t.index ["weather_report_id"], name: "index_check_ins_on_weather_report_id", using: :btree
  end

  create_table "effects", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.integer "effectiveness_days", default: 30
    t.uuid    "supplement_id"
    t.uuid    "symptom_id"
    t.uuid    "user_id"
    t.index ["supplement_id", "symptom_id"], name: "index_effects_on_supplement_id_and_symptom_id", unique: true, using: :btree
    t.index ["supplement_id"], name: "index_effects_on_supplement_id", using: :btree
    t.index ["symptom_id"], name: "index_effects_on_symptom_id", using: :btree
    t.index ["user_id"], name: "index_effects_on_user_id", using: :btree
  end

  create_table "effects_packs", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "effect_id"
    t.uuid     "pack_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["effect_id"], name: "index_effects_packs_on_effect_id", using: :btree
    t.index ["pack_id", "effect_id"], name: "index_effects_packs_on_pack_id_and_effect_id", using: :btree
    t.index ["pack_id"], name: "index_effects_packs_on_pack_id", using: :btree
  end

  create_table "packs", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_packs_on_user_id", using: :btree
  end

  create_table "supplements", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "symptom_groups", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "category",   default: 0
    t.integer  "points",     default: 0
    t.integer  "icon"
  end

  create_table "symptoms", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.uuid     "symptom_group_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["symptom_group_id"], name: "index_symptoms_on_symptom_group_id", using: :btree
  end

  create_table "users", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "device_id"
    t.index ["device_id"], name: "index_users_on_device_id", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  create_table "weather_reports", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "icon"
    t.float    "cloud_cover"
    t.float    "temperature"
    t.float    "precip_probability"
    t.string   "precip_type"
    t.float    "moon_phase"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.float    "lat"
    t.float    "lng"
  end

  add_foreign_key "check_in_symptoms", "check_ins"
  add_foreign_key "check_in_symptoms", "symptoms"
  add_foreign_key "check_ins", "users"
  add_foreign_key "check_ins", "weather_reports"
  add_foreign_key "effects", "supplements"
  add_foreign_key "effects", "symptoms"
  add_foreign_key "effects", "users"
  add_foreign_key "effects_packs", "effects"
  add_foreign_key "effects_packs", "packs"
  add_foreign_key "packs", "users"
  add_foreign_key "symptoms", "symptom_groups"
end
