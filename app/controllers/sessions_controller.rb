class SessionsController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	# prevents error upon login
  	@user = User.new
  	
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to user.homepage, :notice => "Logged in successfully."
    #       # check user's role to determine where to send them
    #       if user.is_writer?
    #         redirect_to write_path, :notice => "Logged in successfully."
    #       elsif user.is_approver?
    #         redirect_to approve_path, :notice => "Logged in successfully."
    # else
    #         redirect_to new_event_path, :notice => "Logged in successfully."
    #       end
  	  
    else
      flash.now[:alert] = "Invalid login or password."
      render :action => 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "You have been logged out."
  end
end
