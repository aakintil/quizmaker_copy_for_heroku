class ChangeQuestionTextStringToText < ActiveRecord::Migration
  def up
	change_column :questions, :text, :text	
	change_column :questions, :answer, :text	
  end

  def down
  end
end
