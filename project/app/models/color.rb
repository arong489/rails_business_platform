class Color < ApplicationRecord
  has_many :products, dependent: :destroy
end
