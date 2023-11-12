class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # user avatar
  has_one_attached :avatar, dependent: :destroy
  # cart items
  has_many :cart_items, dependent: :destroy
  has_many :cart_products, through: :cart_items, source: :product
  # favorite products
  has_many :favorites_items, dependent: :destroy
  has_many :favorite_products, through: :favorites_items, source: :product

  has_many :transaction_orders
end
