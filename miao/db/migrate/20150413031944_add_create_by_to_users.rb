class AddCreateByToUsers < ActiveRecord::Migration
  def change
    add_column :users, :create_by, :integer
  end
end
