class State < ApplicationRecord
  belongs_to :feedback

  validates :device, :os, :memory, :storage, presence: true
end
