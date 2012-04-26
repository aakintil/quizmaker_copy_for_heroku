Given /^a logged in writer$/ do
  visit login_url
  fill_in "login", :with => "ehemingway"
  fill_in "password", :with => "secret"
  find("#sign-in").click
end

Given /^another writer with questions$/ do 
  @by_another_writer = Factory.create(:question, :written_by => @jausten, :text => "Do fish get thirsty?", :answer => "Always.", :keyword => 2, :created_on => 25.hours.ago) 
end

Given /^an editable question$/ do
  @editable_question = Factory.create(:question, :written_by => @ehemingway, :text => "This is the editable question?", :answer => "Hopefully I can edit.", :keyword => 2, :created_on => 3.hours.ago)    
end

Given /^an existing question with the following data:$/ do |table|
  # table is a Cucumber::Ast::Table, i.e.,
  # Given I have:
  #   | a | b |
  #   | c | d |
  data = table.raw  # stores [['a', 'b'], ['c', 'd']] in the data variable
    attributes = Hash.new # make a hash to store the attributes
    data.each do |k,v| 
      attributes[k] = v
  end
  @q = @ehemingway.questions.create!(attributes)
end

