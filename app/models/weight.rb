class Weight < ApplicationRecord
  include PgSearch::Model

  attr_accessor :date

  pg_search_scope :search_by_value_and_created_at,
                  against: [:value, :created_at],
                  using: {
                    tsearch: { prefix: true }
                  }

  belongs_to :user
  has_many_attached :photos

  validates :value, presence: true
end
