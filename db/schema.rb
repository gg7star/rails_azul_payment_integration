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

ActiveRecord::Schema.define(version: 20180409050733) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "azul_jsons", force: :cascade do |t|
    t.string "channel"
    t.string "store"
    t.string "card_number"
    t.string "expiration"
    t.string "pos_input_mode"
    t.string "trx_type"
    t.string "amount"
    t.string "currency_pos_code"
    t.string "payments"
    t.string "plan"
    t.string "original_date"
    t.string "original_trx_ticket_nr"
    t.string "customer_service_phone"
    t.string "cvc"
    t.string "acquirer_ref_data"
    t.string "order_number"
    t.string "custom_order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "itbis"
    t.string "revenue_or_limit"
    t.string "authorization_code"
    t.string "iso_code"
    t.string "rrn"
    t.string "lot_number"
    t.string "e_commerce_url"
    t.string "azul_json_url"
    t.string "auth1"
    t.string "auth2"
  end

  create_table "azuls", force: :cascade do |t|
    t.string "merchant_id"
    t.string "merchant_type"
    t.string "merchant_name"
    t.string "auth_key"
    t.string "url_azul"
    t.string "approved_url"
    t.string "declined_url"
    t.string "cancel_url"
    t.string "response_post_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "custom_field_1"
    t.string "custom_field_1_label"
    t.string "custom_field_1_value"
    t.integer "custom_field_2"
    t.string "custom_field_2_label"
    t.string "custom_field_2_value"
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
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
