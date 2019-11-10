# frozen_string_literal: true

# ExpiredScope
module ExpiredScope
  extend ActiveSupport::Concern

  included do
    scope :active_at, -> (time) do
      where(arel_table[:expired_at].gt(time)
        .or(arel_table[:expired_at].eq(nil)))
    end
    scope :active, -> { active_at(Time.zone.now) }
  end
end
