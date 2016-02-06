# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160206225222) do

  create_table "bancos", force: :cascade do |t|
    t.string   "descripcion", limit: 255,               null: false
    t.string   "codigo",      limit: 255, default: "0"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "documents", force: :cascade do |t|
    t.integer  "folder_id",         limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "file_file_name",    limit: 255
    t.string   "file_content_type", limit: 255
    t.integer  "file_file_size",    limit: 4
    t.datetime "file_updated_at"
  end

  add_index "documents", ["folder_id"], name: "index_documents_on_folder_id", using: :btree

  create_table "folders", force: :cascade do |t|
    t.float    "price",       limit: 24
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "order_id",    limit: 4
    t.integer  "service_id",  limit: 4
    t.integer  "amount",      limit: 4
    t.text     "description", limit: 65535
    t.string   "pages",       limit: 255
  end

  add_index "folders", ["order_id"], name: "index_folders_on_order_id", using: :btree
  add_index "folders", ["service_id"], name: "index_folders_on_service_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.string   "status",     limit: 255, default: "1"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "user_id",    limit: 4
    t.integer  "payment_id", limit: 4
  end

  add_index "orders", ["payment_id"], name: "index_orders_on_payment_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.integer  "transfer_number",  limit: 8,                 null: false
    t.integer  "shipping",         limit: 1,     default: 0, null: false
    t.text     "shipping_address", limit: 65535
    t.integer  "process",          limit: 1,     default: 1, null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "Total_price",      limit: 4,                 null: false
    t.integer  "banco_id",         limit: 4
  end

  add_index "payments", ["banco_id"], name: "index_payments_on_banco_id", using: :btree

  create_table "seed_migration_data_migrations", force: :cascade do |t|
    t.string   "version",     limit: 255
    t.integer  "runtime",     limit: 4
    t.datetime "migrated_on"
  end

  create_table "services", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.string   "ink",         limit: 255
    t.float    "price",       limit: 24
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "nombre",                 limit: 255
    t.string   "apellido",               limit: 255
    t.string   "telefono",               limit: 255
    t.string   "cedula",                 limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.integer  "admin",                  limit: 4,   default: 0
    t.integer  "jn",                     limit: 4
    t.string   "city",                   limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "documents", "folders"
  add_foreign_key "orders", "payments"
  add_foreign_key "orders", "users"
  add_foreign_key "payments", "bancos"
end
