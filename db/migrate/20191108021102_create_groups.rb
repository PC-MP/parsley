class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups, comment: 'グループ' do |t|

      ## Columns
      t.string :name, null: false, limit: 40, comment: 'グループ名'

      ## Record state
      t.timestamps
      t.integer   :lock_version, default: 0, comment: 'レコードバージョン'
      t.timestamp :deleted_at,               comment: '削除日時'
    end
  end
end
