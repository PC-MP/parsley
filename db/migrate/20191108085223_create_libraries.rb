class CreateLibraries < ActiveRecord::Migration[6.0]
  def change
    create_table :libraries, comment: 'ライブラリ' do |t|

      ## References
      t.references :group, null: false, foreign_key: true, comment: '所属グループ'
      t.references :user,  null: false, foreign_key: true, comment: '作成者'

      ## Columns
      t.string :name, null: false, limit: 40, comment: 'ライブラリ名'

      ## Record state
      t.timestamps
      t.integer   :lock_version, default: 0, comment: 'レコードバージョン'
      t.timestamp :deleted_at,               comment: '削除日時'
    end
  end
end
