class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :password_confirmation
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.string :nom
      t.string :prénom
      t.string :email
      t.date :date_naissance
      t.string :alias
      t.integer :evenement_id

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
