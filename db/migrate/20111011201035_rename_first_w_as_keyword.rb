class RenameFirstWAsKeyword < ActiveRecord::Migration
  def self.up
  	rename_column :questions, :first_w, :keyword
  end

  def self.down
  	rename_column :questions, :keyword, :first_w
  end
end
