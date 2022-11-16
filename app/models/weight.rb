class Weight < ApplicationRecord
  belongs_to :user
  has_many_attached :photos

  validates :value, presence: true
end
