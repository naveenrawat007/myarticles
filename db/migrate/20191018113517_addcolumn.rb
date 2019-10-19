class Addcolumn < ActiveRecord::Migration[6.0]
  def change
    add_reference :articles, :person, foreign_key: true
  end
end
