class AddIndividualParametersToQuiz < ActiveRecord::Migration
  def self.up
  	remove_column :quizzes, :parameters
    add_column :quizzes, :interrogative, :integer
    add_column :quizzes, :finish_the_verse, :integer
    add_column :quizzes, :quote, :integer
    add_column :quizzes, :reference, :integer
    add_column :quizzes, :multiple_answer, :integer
    add_column :quizzes, :situation, :integer
  end

  def self.down
    add_column :quizzes, :parameters, :string
    remove_column :quizzes, :interrogative
    remove_column :quizzes, :finish_the_verse
    remove_column :quizzes, :quote
    remove_column :quizzes, :reference
    remove_column :quizzes, :multiple_answer
    remove_column :quizzes, :situation
  end
end
