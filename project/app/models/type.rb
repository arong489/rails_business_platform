class Type < ApplicationRecord
  has_many :products, dependent: :destroy
end
