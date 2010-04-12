class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :login
      t.string :hashed_password
      t.string :firstname
      t.string :lastname
      t.string :mail
      t.datetime :last_login_on

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
