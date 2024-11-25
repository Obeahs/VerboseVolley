class Customer < ApplicationRecord
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :validatable

  belongs_to :province, optional: true
  has_one :cart, dependent: :destroy
  has_many :orders

  validates :customer_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :phone_number, presence: true, format: { with: /\A\d+\z/, message: "only allows numbers" }
  validates :address, presence: true

  after_create :create_cart

  def self.ransackable_associations(auth_object = nil)
    ["orders"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "customer_name", "email", "id", "password", "phone_number", "address", "province_id", "updated_at"]
  end

  private

  def create_cart
    Cart.create!(customer: self)
  end
end
