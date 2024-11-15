class Customer < ApplicationRecord
    has_many :orders
    has_many :carts, through: :orders
  
    validates :customer_name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true
    validates :phone_number, presence: true, format: { with: /\A\d+\z/, message: "only allows numbers" }

    def self.ransackable_associations(auth_object = nil)
      ["carts", "orders"]
    end

    def self.ransackable_attributes(auth_object = nil)
      ["created_at", "customer_name", "email", "id", "password", "phone_number", "updated_at"]
    end

  end
  