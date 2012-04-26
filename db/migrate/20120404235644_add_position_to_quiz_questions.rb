class AddPositionToQuizQuestions < ActiveRecord::Migration
  def change
    add_column :quiz_questions, :position, :integer
  end
end
