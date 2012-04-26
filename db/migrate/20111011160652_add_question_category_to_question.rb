class AddQuestionCategoryToQuestion < ActiveRecord::Migration
  def self.up
  	rename_column :questions, :question_type_id, :question_category_id
  end

  def self.down
  	rename_column :questions, :question_category_id, :question_type_id
  end
end
