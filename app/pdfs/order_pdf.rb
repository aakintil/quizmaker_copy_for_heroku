class OrderPdf < Prawn::Document
  
  def initialize(quiz, owner)
    super(top_margin: 70)
    @quiz = quiz
    @owner = owner
    
    quiz_title
    style
    logo
    quiz_questions
    page_numbers
  end
  
  def style
    font ("Times-Roman")
    font_size(10)
  end
  
  def logo
    img = "app/assets/images/white_logo.png"
    
     repeat :all do
         image img, :at => bounds.bottom_left, :scale =>0.25
        end
  end
  
  
  def quiz_title
    move_down 10
    text "Quiz: ' #{@quiz.event.title} '", size: 30, style: :bold
    text "Owner: #{@owner.name}", size: 15, style: :italic
  end
  
  
  def quiz_questions
     move_down 20
     table quiz_question_rows do
      row(0).font_style = :bold
      columns(1..5).align = :center
      self.row_colors = ["FFEAD7", "FFFFFF"]
      self.header = true
     end
  end
  
  def quiz_question_rows
    
    [["  #  ", "  Question Type  ", "  Question  ", "Answer", "    Reference"]] + 
    @quiz.quiz_questions.map do |q|
    
      [q.position, q.question.question_type.name, q.question.text.to_s, q.question.answer.capitalize, q.question.reference ]
    end
  end 
  
  def page_numbers
    
    string = "page <page> of <total>"
     # Green page numbers 1 to 7
     options = { :at => [bounds.right - 150, 0],
                 :width => 150,
                 :align => :right,
                 :page_filter => (1..7),
                 :start_count_at => 1,
                 :color => "000000" }
     number_pages string, options
  end
  
end 