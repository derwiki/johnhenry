class AddUsersAndPayments < ActiveRecord::Migration
  def change
    create_table "payments", force: true do |t|
      t.integer  "user_id"
      t.string   "stripe_token"
      t.string   "stripe_customer_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.decimal  "amount",             default: 0.0, null: false
    end

    add_index "payments", ["user_id"], name: "index_payments_on_user_id"

    create_table "users", force: true do |t|
      t.string   "email",                  default: "", null: false
      t.string   "encrypted_password",     default: "", null: false
      t.string   "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.integer  "sign_in_count",          default: 0,  null: false
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.string   "current_sign_in_ip"
      t.string   "last_sign_in_ip"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "stripe_customer_id"
    end

    add_index "users", ["email"], name: "index_users_on_email", unique: true
    add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end
end
