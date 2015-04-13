class AddToUserIdToTwitters < ActiveRecord::Migration
  def change
    add_column :twitters, :to_user_id, :integer
  end
end
