class Design < ApplicationRecord
  has_many :products, dependent: :destroy
end
