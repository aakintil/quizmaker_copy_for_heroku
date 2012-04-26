class QuestionsController < ApplicationController
	before_filter :login_required
	

 	respond_to :html, :json

	#load_and_authorize_resource

	
  def index
	@question = Question.new
    @questions = Question.all.paginate :page => params[:page], :per_page => 10
  end
  
  def writer_index
 	  @question = Question.new
  	@questions = Question.all.by_writer(current_user.id)#.paginate :page => params[:page], :per_page => 5
  end
  
  def approver_index
  	@questions = Question.awaiting_approval.all#.paginate :page => params[:page], :per_page => 5 #.awaiting_approval
    # @recent_questions = Question.awaiting_approval.all
    # @approved_questions = Question.approved.all
  	
  	# questions by question type
    # @int_questions = Question.int.awaiting_approval.all
    # @ftv_questions = Question.ftv.awaiting_approval.all
    # @qt_questions = Question.qt.awaiting_approval.all
    # @ref_questions = Question.ref.awaiting_approval.all
    # @ma_questions = Question.ma.awaiting_approval.all
    # @sit_questions = Question.sit.awaiting_approval.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(params[:question])
    @question.written_by = current_user.id
    unless @question.question_type == nil
    @question.question_category_id = @question.question_type.question_category_id
	end
    
	# set the section for this question
	@question.section_id = @question.set_section

    if @question.save
      redirect_to write_path, :notice => "Question created. You have 24 hours to edit before it is submitted for approval."
    else
      render :action => 'new'
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

# !!! DO NOT USE THIS UPDATE. IT SCREWS UP INLINE EDIT --DAVID !!! 
  # def update
  #     @question = Question.find(params[:id])
  # 
  #     # @question.question_type_id = params[:question][:question_type_id]
  #     # @question.question_category_id = @question.question_type.question_category_id
  # 
  #     #authorize! :update, @question
  #     # @question.question_type_id = params[:question][:question_type_id]
  #     #     @question.question_category_id = @question.question_type.question_category_id
  # 
  # 
  #     # ##### NOT USED ANYMORE BECAUSE OF INLINE EDIT ####
  #     #     # get fields from the form to  update the question's section
  #     #     @question.book = params[:question][:book]
  #     #     @question.chapter = params[:question][:chapter]
  #     #     @question.verse = params[:question][:verse]
  #     #     @question.section_id = @question.set_section
  #     #     #---------------------------------------------------------
  #     #     
  #     #     # if the the question has been approved, set the approver and the date approved	
  #     # 	unless params[:question][:approval_level] == nil
  #     #     	@question.approved_by = current_user.id
  #     #     	@question.approved_on = DateTime.now
  #     # 	end
  #     ##### END NOT USED ANYMORE #####
  #     
  #     #update question attributes
  # 	@question.update_attributes(params[:question])
  # 
  # 	# if the quesiton is marked as refused, drop from database
  #   	# if @question.approval_level == -1
  #   	# 		@question.destroy
  #   	# 		destroyed = 1
  #   	# 	end
  # 	
  # 	#Determine where to redirect user to and message to display
  #   	if current_user.is_approver? && destroyed == 1
  #   		redirect_to approve_path, :notice => "Successfully deleted question."  
  # 	elsif current_user.is_writer?
  # 	  	redirect_to write_path, :notice  => "Successfully updated question."  
  #  	elsif current_user.is_approver?
  # 	  	redirect_to approve_path, :notice  => "Successfully updated question."
  # 	 else
  # 	  	redirect_to @question, :notice  => "Successfully updated question."
  # 	 end
  # 
  #   end


  def update
    @question = Question.find(params[:id])

    # @question.question_type_id = params[:question][:question_type_id]
    # @question.question_category_id = @question.question_type.question_category_id

    # authorize! :update, @question
    #     @question.question_type_id = params[:question][:question_type_id]
    #     @question.question_category_id = @question.question_type.question_category_id

    
    # # get fields from the form to update the question's section
    # @question.book = params[:question][:book]
    # @question.chapter = params[:question][:chapter]
    # @question.verse = params[:question][:verse]
    # @question.section_id = @question.set_section
    #---------------------------------------------------------
    
    # # if the the question has been approved, set the approver and the date approved
    #     unless params[:question][:approval_level] == nil
    #       @question.approved_by = current_user.id
    #       @question.approved_on = DateTime.now
    # end
	
    @question.update_attributes(params[:question])
    unless @question.approval_level == -1
    respond_with @question
	end
	
	# set the section for this question
	#@question.section_id = @question.set_section
    
    # the quesiton is marked as refused, drop from database
    if @question.approval_level == -1
    	@question.destroy
        destroyed = 1
        redirect_to approve_path, :notice => "Successfully deleted question"
        return
    end
    # if @question.update_attributes(params[:question])
    #   # determine user and send them to appropriate page
    #       if current_user.is_writer?
    #         redirect_to write_path, :notice  => "Successfully updated question."
    #       elsif current_user.is_approver?
    #       redirect_to approve_path, :notice  => "Successfully updated question."
    #       else
    #         redirect_to @question, :notice  => "Successfully updated question."
    #       end
    # else
    #   render :action => 'edit'
    # end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    if current_user.is_writer?
    	redirect_to write_path, :notice => "Successfully destroyed question."
	elsif current_user.is_approver?
    	redirect_to approve_path, :notice => "Successfully destroyed question."
	else
		redirect_to questions_url, :notice => "Successfully destroyed question."
	end
  end
  
  def sort
     params[:question].each_with_index do |id, index|
       Question.update_all({position: index+1}, {id: id})
     end
     render nothing: true
   end
   
end
