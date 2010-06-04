class CreateClasses < ActiveRecord::Migration
  def self.up
    create_table :classes do |t|
      t.integer :user_id
      t.integer :etudiant_id
      t.integer :periode_id

      t.timestamps
    end
  end

  def self.down
    drop_table :classes
  end
end
