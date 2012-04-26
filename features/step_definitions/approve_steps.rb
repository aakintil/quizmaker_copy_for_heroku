Given /^a logged in approver$/ do
	fill_in "login", :with => "atrebek"
	fill_in "password", :with => "secret"
	click_button "sign-in"
end
