class Addcolumnforotpexpire < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :otp_expire, :time
  end
end
