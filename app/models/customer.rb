class Customer < ApplicationRecord
    has_many :orders
    has_many :carts, through: :orders
    has_one_attached :image
  
    validates :customer_name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true
    validates :phone_number, presence: true

    def self.ransackable_associations(auth_object = nil)
        ["carts", "image_attachment", "image_blob", "orders"]
      end

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "customer_name", "email", "id", "password", "phone_number", "updated_at"]
    end

      
  end
  