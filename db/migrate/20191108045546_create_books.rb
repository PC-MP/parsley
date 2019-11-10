class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books, comment: '書籍マスター' do |t|

      ## Columns
      t.string :title,    null: false,            comment: 'タイトル'
      t.string :isbn13,   null: false, limit: 13, comment: 'ISBN-13'
      t.string :isbn10,   null: false, limit: 10, comment: 'ISBN-10'
      t.string :jan,      null: false, limit: 13, comment: 'JANコード'
      t.string :image_url,                        comment: '表紙画像'
      t.text   :json,                             comment: 'その他情報'

      ## Record state
      t.timestamps
      t.integer   :lock_version, default: 0, comment: 'レコードバージョン'
      t.timestamp :deleted_at,               comment: '削除日時'
    end
  end
end
