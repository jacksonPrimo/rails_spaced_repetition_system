class Card < ApplicationRecord
  belongs_to :user
  belongs_to :pack

  validates :front, presence: true, uniqueness: { scope: :pack_id, message: 'já existe um cartão com esta frente neste pack' }
  validates :back, presence: true
end
