class Pack < ApplicationRecord
  belongs_to :user
  has_many :cards, dependent: :destroy
end
