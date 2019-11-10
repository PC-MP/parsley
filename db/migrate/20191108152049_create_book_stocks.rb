class CreateBookStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :book_stocks, comment: '蔵書情報' do |t|

      ## References
      t.references :book,    null: false, foreign_key: true, comment: '書籍'
      t.references :library, null: false, foreign_key: true, comment: 'ライブラリ'

      ## Columns
      t.integer :stock, null: false, default: 1, limit: 1, comment: '蔵書数'

      ## Record state
      t.timestamps
      t.integer   :lock_version, default: 0, comment: 'レコードバージョン'
      t.timestamp :deleted_at,               comment: '削除日時'
    end
  end
end
