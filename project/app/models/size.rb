class Size < ApplicationRecord
  has_many :products, dependent: :destroy
end
