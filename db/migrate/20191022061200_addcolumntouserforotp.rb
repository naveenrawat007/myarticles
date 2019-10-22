class Addcolumntouserforotp < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :code, :integer
    add_column :users, :active, :boolean 
  end
end
