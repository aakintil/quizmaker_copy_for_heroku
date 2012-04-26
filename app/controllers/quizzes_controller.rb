class QuizzesController < ApplicationController
  include ActionView::Helpers::TextHelper
	before_filter :login_required
	
	authorize_resource
  # GET /quizzes
  # GET /quizzes.xml
  def index
    @quizzes = Quiz.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @quizzes }
    end
  end

  # GET /quizzes/1
  # GET /quizzes/1.xml
  def show
    @quiz = Quiz.find(params[:id])
    
    @sections = @quiz.sections
    @owner = current_user
    @positions = Array.new
     i = 0
        @quiz.quiz_questions.each do |quiz_question|
        i += 1
        quiz_question.position = i
        @positions.push(quiz_question.position)
        end

  
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @quiz }
      format.pdf do
        pdf = OrderPdf.new(@quiz, @owner)
        send_data pdf.render, filename: "Quiz For #{@quiz.event.title}.pdf",
                              type: "application/pdf",
                              disposition: "inline",
                              layout: "landscape"
      end
    end
  end

  # GET /quizzes/new
  # GET /quizzes/new.xml
  def new
    @quiz = Quiz.new
    
    @sections = Section.all

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @quiz }
    end
  end

  # GET /quizzes/1/edit
  def edit
    @quiz = Quiz.find(params[:id])
    
    @sections = Section.all
  end

  # POST /quizzes
  # POST /quizzes.xml
  def create
    @quiz = Quiz.new(params[:quiz])
    
    @sections = Section.all
    
  
    # the parameters of quiz generation
    # @interrogative = params[:quiz][:interrogative]
    #     @finish_the_verse = params[:quiz][:finish_the_verse]
    #     @quote = params[:quiz][:quote]
    #     @reference = params[:quiz][:reference]
    #     @multiple_answer = params[:quiz][:multiple_answer]
    #     @situation = params[:quiz][:situation]
    
    # @interrogative, @finish_the_verse, @quote, @reference, @multiple_answer = 0
    #     @quiz.quiz_questions.each do |quiz_question|
    #     	if quiz_question.question.question_type.name == "Interrogative"
    #     		@interrogative += 1
    #     	elsif quiz_question.question.question_type.name == "Finish The Verse"
    #     		@finish_the_verse += 1
    #     	elsif quiz_question.question.question_type.name == "Quote"
    #     		@quote += 1
    #     	elsif quiz_question.question.question_type.name == "Reference"
    #     		@reference += 1
    #     	elsif quiz_question.question.question_type.name == "Multiple Answer"
    #     		@multiple_answer += 1
    #     	end
    #     end
    
    
	
	
    respond_to do |format|
      if @quiz.save
        format.html { redirect_to(@quiz, :notice => 'Quiz was successfully created.') }
        format.xml  { render :xml => @quiz, :status => :created, :location => @quiz }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @quiz.errors, :status => :unprocessable_entity }
      end
    end
    
    # @quiz.interrogative = @interrogative
    #     	@quiz.finish_the_verse = @finish_the_verse
    #     	@quiz.quote = @quote
    #     	@quiz.reference = @reference
    #     	@quiz.multiple_answer = @multiple_answer
    #     	@quiz.save
    
  end

  # PUT /quizzes/1
  # PUT /quizzes/1.xml
  def update
    @quiz = Quiz.find(params[:id])
    
    @section = Section.all
    
	# the parameters of quiz generation
    # @quiz.interrogative = params[:quiz][:interrogative]
    #     @quiz.finish_the_verse = params[:quiz][:finish_the_verse]
    #     @quiz.quote = params[:quiz][:quote]
    #     @quiz.reference = params[:quiz][:reference]
    #     @quiz.multiple_answer = params[:quiz][:multiple_answer]
    #     @quiz.situation = params[:quiz][:situation]
    
    # generate the quiz
	#@quiz.generate_quiz(@quiz.interrogative, @quiz.finish_the_verse, @quiz.quote, @quiz.reference, @quiz.multiple_answer, @quiz.situation)
    respond_to do |format|
      if @quiz.update_attributes(params[:quiz])
        format.html { redirect_to(@quiz, :notice => 'Quiz was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @quiz.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /quizzes/1
  # DELETE /quizzes/1.xml
  def destroy
    @quiz = Quiz.find(params[:id])
    @quiz.destroy
    @quest = @quiz.quiz_questions
    respond_to do |format|
      format.html { redirect_to(quizzes_url) }
      format.xml  { head :ok }
    end
  end
  
  def sort
    params[:quiz_question].each_with_index do |id, index|
          QuizQuestion.update_all({position: index+1}, {id: id})
  end
    render nothing: true
  end
  
end
