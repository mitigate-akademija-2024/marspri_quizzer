# Rename this file to db/migrate/YYYYMMDDHHMMSS_add_email_to_users.rb
# Replace YYYYMMDDHHMMSS with the timestamp you generated

class AddEmailToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :email, :string
    add_index :users, :email, unique: true
  end
end
