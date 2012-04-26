class RenameQuestionTypesToQuestionCategoriesInQuiz < ActiveRecord::Migration
 def self.up
  rename_column :quizzes, :question_types, :question_categories
  end

  def self.down
  	rename_column :quizzes, :question_categories, :question_types
  end
end
