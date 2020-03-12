class Feedback < ApplicationRecord
  has_one :state

  enum priority: %i[minor major critical]

  validates_uniqueness_of :number, scope: :company_token
  validates :priority, :number, :company_token, presence: true
end
