module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #

  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'

    when /^the writer page$/
      '/questions/writer_index'
      
    when /^the approver page$/
  	  '/questions/approver_index'
  	# i don't think this path is necessary, "the write/approve page" should be automatically mapped already
  
    ################### Approver ###################
    when /^not my approver page$/
      '/questions/1'

    when /^an early question$/
      '/questions/3'
      
    ################### Writer ###################
    when /^the add new question page$/
      new_question_path

    when /^the pending approval question details page$/
      question_path(@pending1)

    when /^the editable question details page$/
      question_path(@editable_question)
	
    when /^the edit question page$/
      edit_question_path(@editable_question)

    when /^the other writer's question details page$/
      question_path(@by_another_writer)
 
    when /^edit the other writer's question$/
   	  edit_question_path(@by_another_writer)
   	  

  	
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
