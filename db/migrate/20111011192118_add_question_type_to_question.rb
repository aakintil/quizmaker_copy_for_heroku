class AddQuestionTypeToQuestion < ActiveRecord::Migration
  def self.up
  	add_column :questions, :question_type_id, :integer
  end

  def self.down
  	remove_column :questions, :question_type_id
  end
end
