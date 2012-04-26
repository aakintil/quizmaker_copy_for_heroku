class QuestionTypesController < ApplicationController
	before_filter :login_required
	
	authorize_resource
	
  def index
    @question_types = QuestionType.all
  end

  def show
    @question_type = QuestionType.find(params[:id])
  end

  def new
    @question_type = QuestionType.new
  end

  def create
    @question_type = QuestionType.new(params[:question_type])
    if @question_type.save
      redirect_to @question_type, :notice => "Successfully created question type."
    else
      render :action => 'new'
    end
  end

  def edit
    @question_type = QuestionType.find(params[:id])
  end

  def update
    @question_type = QuestionType.find(params[:id])
    if @question_type.update_attributes(params[:question_type])
      redirect_to @question_type, :notice  => "Successfully updated question type."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @question_type = QuestionType.find(params[:id])
    @question_type.destroy
    redirect_to question_types_url, :notice => "Successfully destroyed question type."
  end
end
