class CreateInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :invitations, comment: 'ライブラリへの招待' do |t|

      ## References
      t.references :user,       null: false, foreign_key: true,                 comment: '招待されたユーザー'
      t.references :library,    null: false, foreign_key: true,                 comment: '招待元のライブラリ'
      t.references :invited_by, null: false, foreign_key: { to_table: :users }, comment: '招待したユーザー'

      ## Columns
      t.integer    :role,       null: false, default: 1, limit: 1, comment: '招待されたユーザーの権限'
      t.timestamp  :expired_at,                                    comment: '招待の有効期限'

      ## Record state
      t.timestamps
      t.integer   :lock_version, default: 0, comment: 'レコードバージョン'
      t.timestamp :deleted_at,               comment: '削除日時'

      ## Index
      t.index %i[library_id user_id], unique: true
    end
  end
end
