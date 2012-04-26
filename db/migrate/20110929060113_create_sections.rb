class CreateSections < ActiveRecord::Migration
  def self.up
    create_table :sections do |t|
      t.string :name
      t.string :book
      t.integer :chapter
      t.integer :start_verse
      t.integer :end_verse
      t.timestamps
    end
  end

  def self.down
    drop_table :sections
  end
end
