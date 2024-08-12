class User < ApplicationRecord
  has_many :results
  validates :name, presence: true
end
