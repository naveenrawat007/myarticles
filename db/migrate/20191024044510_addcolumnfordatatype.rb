class Addcolumnfordatatype < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :otp_expire, :datetime
    add_column :users, :otp_expire, :time
  end
end
