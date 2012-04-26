class CreateQuizSections < ActiveRecord::Migration
  def self.up
    create_table :quiz_sections do |t|
      t.integer :quiz_id
      t.integer :section_id

      t.timestamps
    end
  end

  def self.down
    drop_table :quiz_sections
  end
end
