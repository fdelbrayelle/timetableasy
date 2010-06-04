class CreateCours < ActiveRecord::Migration
  def self.up
    create_table :cours do |t|
      t.string :nom
      t.integer :heures_total
      t.integer :heures_reste
      t.integer :evaluation_id

      t.timestamps
    end
  end

  def self.down
    drop_table :cours
  end
end
