class CreateEspaces < ActiveRecord::Migration
  def self.up
    create_table :espaces do |t|
      t.string :code
      t.string :type

      t.timestamps
    end
  end

  def self.down
    drop_table :espaces
  end
end
