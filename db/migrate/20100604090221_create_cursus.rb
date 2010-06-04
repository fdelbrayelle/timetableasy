class CreateCursus < ActiveRecord::Migration
  def self.up
    create_table :cursus do |t|
      t.string :nom
      t.integer :periode_id

      t.timestamps
    end
  end

  def self.down
    drop_table :cursus
  end
end
