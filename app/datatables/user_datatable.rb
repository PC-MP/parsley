# frozen_string_literal: true

# UserDatatable
class UserDatatable < AjaxDatatablesRails::ActiveRecord

  def current_user
    @current_user ||= options[:current_user]
  end

  def view_columns
    @view_columns ||= {
      username: { source: 'User.username' },
      email:    { source: 'User.email' }
    }
  end

  def data
    records.map do |record|
      {
        DT_RowId: record.id,
        username: record.username,
        email:    record.email
      }
    end
  end

  def get_raw_records
    Pundit.policy_scope(current_user, User)
  end

end
