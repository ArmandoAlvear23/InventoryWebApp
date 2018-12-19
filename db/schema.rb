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

ActiveRecord::Schema.define(version: 20180820154125) do

  create_table "access_list_to_ea_points", force: :cascade do |t|
    t.string "al_file_name", limit: 255
    t.string "al_eap_id", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ea_pproof"
  end

  create_table "bes_assets", force: :cascade do |t|
    t.string "asset_id", limit: 255
    t.string "asset_type", limit: 255
    t.string "description", limit: 255
    t.date "commission"
    t.date "decommission"
    t.string "high_impact", limit: 255
    t.string "medium_impact", limit: 255
    t.string "low_impact", limit: 255
    t.string "erc", limit: 255
    t.string "dial_up", limit: 255
    t.string "region_op", limit: 255
    t.string "register_func", limit: 255
    t.string "cc1", limit: 255
    t.string "cc2", limit: 255
    t.string "cc3", limit: 255
    t.string "cc4", limit: 255
    t.string "cc5", limit: 255
    t.string "cc6", limit: 255
    t.string "cc7", limit: 255
    t.string "cc8", limit: 255
    t.string "tf1", limit: 255
    t.string "tf2", limit: 255
    t.string "tf3", limit: 255
    t.string "tf4", limit: 255
    t.string "tf5", limit: 255
    t.string "tf6", limit: 255
    t.string "tf7", limit: 255
    t.string "tf8", limit: 255
    t.string "g1", limit: 255
    t.string "g2", limit: 255
    t.string "g3", limit: 255
    t.string "g4", limit: 255
    t.string "g5", limit: 255
    t.string "aa1", limit: 255
    t.string "aa2", limit: 255
    t.string "aa3", limit: 255
    t.string "dp1", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "proof"
    t.string "location", limit: 255
  end

  create_table "bes_cyber_assets", force: :cascade do |t|
    t.string "ca_id", limit: 255
    t.string "ca_classification", limit: 255
    t.string "bcs_id", limit: 255
    t.string "impact_rating", limit: 255
    t.string "asset_id", limit: 255
    t.string "protocol", limit: 255
    t.string "ip_address", limit: 255
    t.string "esp_identifier", limit: 255
    t.string "ca_dial_up", limit: 255
    t.string "cip_005", limit: 255
    t.string "ca_ira", limit: 255
    t.string "ca_psp", limit: 255
    t.string "ca_bcs_login", limit: 255
    t.string "bcs_login", limit: 255
    t.string "log_collector", limit: 255
    t.date "activation_date"
    t.date "deactivation_date"
    t.string "ca_function", limit: 255
    t.string "ca_other", limit: 255
    t.string "ca_vendor", limit: 255
    t.string "ca_model", limit: 255
    t.string "os_firmware", limit: 255
    t.string "os_other", limit: 255
    t.string "external_conn", limit: 255
    t.string "system_logging", limit: 255
    t.string "alerting", limit: 255
    t.string "reg_entity_ncr", limit: 255
    t.string "region", limit: 255
    t.string "function", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "proof"
  end

  create_table "bes_cyber_systems", force: :cascade do |t|
    t.string "BES_cyber_system", limit: 255
    t.string "BES_asset_BCS", limit: 255
    t.string "BES_system", limit: 255
    t.string "impact_rating_BCS", limit: 255
    t.string "justification", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "q1", limit: 255
    t.string "q2", limit: 255
    t.string "q3", limit: 255
    t.string "q4", limit: 255
    t.string "q5", limit: 255
    t.string "q6", limit: 255
    t.string "q7", limit: 255
    t.string "q8", limit: 255
    t.string "q9", limit: 255
  end

  create_table "ea_points", force: :cascade do |t|
    t.string "eap_id", limit: 255
    t.string "eap_interface", limit: 255
    t.string "eap_ip", limit: 255
    t.string "eap_ca_eacms", limit: 255
    t.string "eap_esp_id", limit: 255
    t.string "eap_access_list", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "es_perimeters", force: :cascade do |t|
    t.string "esp_id", limit: 255
    t.string "esp_description", limit: 255
    t.string "esp_network", limit: 255
    t.string "esp_conn", limit: 255
    t.string "esp_remote", limit: 255
    t.string "esp_eacms", limit: 255
    t.string "esp_topology", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "network_top_to_es_perimeters", force: :cascade do |t|
    t.string "nt_file_name", limit: 255
    t.string "nt_esp_id", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "es_pproof"
  end

  create_table "ps_perimeters", force: :cascade do |t|
    t.string "psp_id", limit: 255
    t.string "psp_description", limit: 255
    t.string "psp_location", limit: 255
    t.string "psp_asset_id", limit: 255
    t.string "psp_diagrams", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "psp_diagrams_to_ps_perimeters", force: :cascade do |t|
    t.string "psp_dia_file_name", limit: 225
    t.string "psp_dia_psp_id", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ps_pproof"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
