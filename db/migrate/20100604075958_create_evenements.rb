class CreateEvenements < ActiveRecord::Migration
  def self.up
    create_table :evenements do |t|
      t.string :nom
      t.text :description
      t.boolean :readonly
      t.datetime :debut
      t.integer :duree
      t.integer :campu_id
      t.integer :espace_id
      t.integer :intervenant_id
      t.integer :user_id
      t.integer :role_id
      t.integer :classe_id
      t.integer :cour_id
      t.integer :evaluation_id

      t.timestamps
    end
  end

  def self.down
    drop_table :evenements
  end
end
