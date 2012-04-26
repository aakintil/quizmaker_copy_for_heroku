class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.integer :written_by
      t.integer :approved_by
      t.integer :question_type_id
      t.integer :section_id
      t.string :book
      t.integer :chapter
      t.string :verse
      t.string :text
      t.string :answer
      t.integer :first_w
      t.datetime :created_on
      t.datetime :approved_on
      t.integer :approval_level
      t.string :approval_reason
      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
