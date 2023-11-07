class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: :true
  has_one_attached :img, dependent: :destroy

  belongs_to :design
  belongs_to :color
  belongs_to :size
  belongs_to :type
end
