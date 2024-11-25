class PopulateCustomerIdInCarts < ActiveRecord::Migration[7.2]
  def up
    Cart.reset_column_information

    # Iterate through each cart and assign a customer_id
    Cart.find_each do |cart|
      # If the cart doesn't have a customer_id, assign the first customer or default
      customer = cart.customer || Customer.first

      # Assign the customer_id if it's nil
      if cart.customer_id.nil? && customer
        cart.update!(customer_id: customer.id)
      end
    end
  end

  def down
    # No-op (irreversible operation)
  end
end
