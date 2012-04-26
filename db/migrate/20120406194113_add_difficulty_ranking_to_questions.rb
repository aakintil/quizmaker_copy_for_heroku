class AddDifficultyRankingToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :difficulty_ranking, :integer
  end
end
