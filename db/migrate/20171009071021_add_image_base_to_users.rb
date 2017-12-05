class AddImageBaseToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :image_base, :text
  end
end
