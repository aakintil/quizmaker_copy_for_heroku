class CreateQuizzes < ActiveRecord::Migration
  def self.up
    create_table :quizzes do |t|
      t.string :parameters
      t.string :filename
      t.integer :event_id

      t.timestamps
    end
  end

  def self.down
    drop_table :quizzes
  end
end
