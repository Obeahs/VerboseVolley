class Customer < ApplicationRecord
    has_many :orders
    has_many :carts, through: :orders
  
    validates :customer_name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true
    validates :phone_number, presence: true
  end
  