class QuestionCategoriesController < ApplicationController
	before_filter :login_required
	
	authorize_resource
	
  def index
    @question_categories = QuestionCategory.all
  end

  def show
    @question_category = QuestionCategory.find(params[:id])
  end

  def new
    @question_category = QuestionCategory.new
  end

  def create
    @question_category = QuestionCategory.new(params[:question_category])
    if @question_category.save
      redirect_to @question_category, :notice => "Successfully created question category."
    else
      render :action => 'new'
    end
  end

  def edit
    @question_category = QuestionCategory.find(params[:id])
  end

  def update
    @question_category = QuestionCategory.find(params[:id])
    if @question_category.update_attributes(params[:question_category])
      redirect_to @question_category, :notice  => "Successfully updated question category."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @question_category = QuestionCategory.find(params[:id])
    @question_category.destroy
    redirect_to question_categories_url, :notice => "Successfully destroyed question category."
  end
end
