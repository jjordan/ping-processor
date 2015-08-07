class AddCustomerIndexToAppliances < ActiveRecord::Migration
  def change
    add_index :appliances, [:customer], name: "index_appliances_on_customer"
  end
end
