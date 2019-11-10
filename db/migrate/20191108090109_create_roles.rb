class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles, comment: 'グループに対するユーザーの権限' do |t|

      ## References
      t.references :group, null: false, foreign_key: true, comment: 'グループ'
      t.references :user,  null: false, foreign_key: true, comment: 'ユーザー'

      ## Columns
      t.integer    :role, null: false, default: 1, limit: 1, comment: 'ユーザーの権限'

      ## Record state
      t.timestamps
      t.integer   :lock_version, default: 0, comment: 'レコードバージョン'
      t.timestamp :deleted_at,               comment: '削除日時'

      t.index %i[group_id user_id], unique: true
    end
  end
end
