# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_10_065525) do

  create_table "book_stocks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", comment: "蔵書情報", force: :cascade do |t|
    t.bigint "book_id", null: false, comment: "書籍"
    t.bigint "library_id", null: false, comment: "ライブラリ"
    t.integer "stock", limit: 1, default: 1, null: false, comment: "蔵書数"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "lock_version", default: 0, comment: "レコードバージョン"
    t.timestamp "deleted_at", comment: "削除日時"
    t.index ["book_id"], name: "index_book_stocks_on_book_id"
    t.index ["library_id"], name: "index_book_stocks_on_library_id"
  end

  create_table "books", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", comment: "書籍マスター", force: :cascade do |t|
    t.string "title", null: false, comment: "タイトル"
    t.string "isbn13", limit: 13, null: false, comment: "ISBN-13"
    t.string "isbn10", limit: 10, null: false, comment: "ISBN-10"
    t.string "jan", limit: 13, null: false, comment: "JANコード"
    t.string "image_url", comment: "表紙画像"
    t.text "json", comment: "その他情報"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "lock_version", default: 0, comment: "レコードバージョン"
    t.timestamp "deleted_at", comment: "削除日時"
  end

  create_table "groups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", comment: "グループ", force: :cascade do |t|
    t.string "name", limit: 40, null: false, comment: "グループ名"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "lock_version", default: 0, comment: "レコードバージョン"
    t.timestamp "deleted_at", comment: "削除日時"
  end

  create_table "invitation_tickets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", comment: "ライブラリへの招待状", force: :cascade do |t|
    t.bigint "library_id", null: false, comment: "招待元のライブラリ"
    t.string "ticket_hash", limit: 16, null: false, comment: "招待チケット"
    t.timestamp "expired_at", comment: "招待チケットの有効期限"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "lock_version", default: 0, comment: "レコードバージョン"
    t.timestamp "deleted_at", comment: "削除日時"
    t.index ["library_id"], name: "index_invitation_tickets_on_library_id"
    t.index ["ticket_hash"], name: "index_invitation_tickets_on_ticket_hash", unique: true
  end

  create_table "invitations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", comment: "ライブラリへの招待", force: :cascade do |t|
    t.bigint "user_id", null: false, comment: "招待されたユーザー"
    t.bigint "library_id", null: false, comment: "招待元のライブラリ"
    t.bigint "invited_by_id", null: false, comment: "招待したユーザー"
    t.integer "role", limit: 1, default: 1, null: false, comment: "招待されたユーザーの権限"
    t.timestamp "expired_at", comment: "招待の有効期限"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "lock_version", default: 0, comment: "レコードバージョン"
    t.timestamp "deleted_at", comment: "削除日時"
    t.index ["invited_by_id"], name: "index_invitations_on_invited_by_id"
    t.index ["library_id", "user_id"], name: "index_invitations_on_library_id_and_user_id", unique: true
    t.index ["library_id"], name: "index_invitations_on_library_id"
    t.index ["user_id"], name: "index_invitations_on_user_id"
  end

  create_table "libraries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", comment: "ライブラリ", force: :cascade do |t|
    t.bigint "group_id", null: false, comment: "所属グループ"
    t.bigint "user_id", null: false, comment: "作成者"
    t.string "name", limit: 40, null: false, comment: "ライブラリ名"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "lock_version", default: 0, comment: "レコードバージョン"
    t.timestamp "deleted_at", comment: "削除日時"
    t.index ["group_id"], name: "index_libraries_on_group_id"
    t.index ["user_id"], name: "index_libraries_on_user_id"
  end

  create_table "roles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", comment: "グループに対するユーザーの権限", force: :cascade do |t|
    t.bigint "group_id", null: false, comment: "グループ"
    t.bigint "user_id", null: false, comment: "ユーザー"
    t.integer "role", limit: 1, default: 1, null: false, comment: "ユーザーの権限"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "lock_version", default: 0, comment: "レコードバージョン"
    t.timestamp "deleted_at", comment: "削除日時"
    t.index ["group_id", "user_id"], name: "index_roles_on_group_id_and_user_id", unique: true
    t.index ["group_id"], name: "index_roles_on_group_id"
    t.index ["user_id"], name: "index_roles_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", comment: "ユーザー", force: :cascade do |t|
    t.string "email"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "slack_uid"
    t.string "username"
    t.string "display_name"
    t.string "icon_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "lock_version", default: 0, comment: "レコードバージョン"
    t.timestamp "deleted_at", comment: "削除日時"
    t.bigint "group_id", null: false
    t.index ["group_id"], name: "index_users_on_group_id"
    t.index ["slack_uid"], name: "index_users_on_slack_uid", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "book_stocks", "books"
  add_foreign_key "book_stocks", "libraries"
  add_foreign_key "invitation_tickets", "libraries"
  add_foreign_key "invitations", "libraries"
  add_foreign_key "invitations", "users"
  add_foreign_key "invitations", "users", column: "invited_by_id"
  add_foreign_key "libraries", "groups"
  add_foreign_key "libraries", "users"
  add_foreign_key "roles", "groups"
  add_foreign_key "roles", "users"
  add_foreign_key "users", "groups"
end
