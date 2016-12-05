class AddPremiumUserToUsers < ActiveRecord::Migration
  def change
    add_column :users, :premium_user, :boolean, default: false
  end
end
