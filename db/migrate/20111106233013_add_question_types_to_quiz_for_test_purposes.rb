class AddQuestionTypesToQuizForTestPurposes < ActiveRecord::Migration
  def self.up
  	add_column :quizzes, :question_types, :string
  end

  def self.down
  	remove_column :quizzes, :question_types
  end
end
