class Weight < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_by_value_and_created_at,
                  against: %i[value created_at],
                  using: {
                    tsearch: { prefix: true }
                  }

  belongs_to :user
  has_many_attached :photos

  validates :value, presence: true
end
