class CreateCampus < ActiveRecord::Migration
  def self.up
    create_table :campus do |t|
      t.string :nom
      t.string :pays
      t.integer :user_id
      t.integer :espace_id
      t.integer :classe_id

      t.timestamps
    end
  end

  def self.down
    drop_table :campus
  end
end
