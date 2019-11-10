# frozen_string_literal: true

# LibraryPolicy
class LibraryPolicy < ApplicationPolicy

  def index?
    true
  end

  def create?
    %i[owner admin].include? user.role_for(record)
  end

  def update?
    %i[owner admin].include? user.role_for(record)
  end

  def show?
    %i[guest librarian owner admin].include? user.role_for(record)
  end

  def destroy?
    %i[owner admin].include? user.role_for(record)
  end

  class Scope < Scope
    def resolve
      user_id = user.id
      included_library = Library.includes(:invitations, group: :roles)
      scope.includes(:invitations, group: :roles).where(user_id: user_id)
        .or(included_library.where(invitations: { user_id: user_id })
                            .where(Invitation.active.where_values_hash))
        .or(included_library.where(group: { roles: { user_id: user_id } }))
    end
  end
end
