class TransactionOrder < ApplicationRecord
  belongs_to :user
  has_many :transaction_items, dependent: :delete_all

  validates :delivery_address, :delivery_phone, :delivery_postcode, presence: :true
end
