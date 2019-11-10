class CreateInvitationTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :invitation_tickets, comment: 'ライブラリへの招待状' do |t|

      ## References
      t.references :library, null: false, foreign_key: true, comment: '招待元のライブラリ'

      ## Columns
      t.string    :ticket_hash, null: false, limit: 16, comment: '招待チケット'
      t.timestamp :expired_at,                          comment: '招待チケットの有効期限'

      ## Record state
      t.timestamps
      t.integer   :lock_version, default: 0, comment: 'レコードバージョン'
      t.timestamp :deleted_at,               comment: '削除日時'

      ## Index
      t.index :ticket_hash, unique: true
    end
  end
end
