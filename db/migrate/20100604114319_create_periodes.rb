class CreatePeriodes < ActiveRecord::Migration
  def self.up
    create_table :periodes do |t|
      t.string :nom
      t.date :début
      t.date :fin
      t.integer :cour_id

      t.timestamps
    end
  end

  def self.down
    drop_table :periodes
  end
end
