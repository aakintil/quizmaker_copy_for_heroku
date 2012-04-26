require 'will_paginate/array'

class UsersController < ApplicationController
  before_filter :login_required, :except => [:new, :create]
  
  load_and_authorize_resource
	
  def new
  	@roles = [Role.find_by_name("Admin"), Role.find_by_name("Approver"), Role.find_by_name("Writer")]
  	
    if current_user and !current_user.is_admin?
      redirect_to root_url, :notice => "You already have an account."
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(params[:user])
    @roles = [Role.find_by_name("Admin"), Role.find_by_name("Approver"), Role.find_by_name("Writer")]
    
    if @user.save
      if current_user and current_user.is_admin?
        redirect_to users_path, :notice => "Successfully created user \"#{@user.name}\""
      else
        session[:user_id] = @user.id
        redirect_to root_url, :notice => "Thank you for signing up! You are now logged in."
      end
    else
      render :action => 'new'
    end
  end
  
  def index
    @users = User.all#.paginate :page => params[:page], :per_page => 5
    @roles = Role.all
  end

  def edit
    if current_user.is_admin?
      @user = User.find(params[:id])
    else
      @user = current_user
    end
    @roles = [Role.find_by_name("Admin"), Role.find_by_name("Approver"), Role.find_by_name("Writer")]
  end

  def update
    if current_user.is_admin?
      @user = User.find(params[:id])
    else
      @user = current_user
    end
    
    if @user.update_attributes(params[:user])
      if current_user.is_admin? and @user != current_user
        redirect_to current_user.homepage, :notice => "#{@user.name}'s profile has been updated."
      else
        redirect_to @user.homepage, :notice => "Your profile has been updated."
      end
    else
      render :action => 'edit'
    end
  end
  
  
  def edit_roles
    
    userRoles = params[:userRoles]
    
    allUsers = User.all
    allRoles = Role.all
    
    @modifiedUsers = []
    usersWithRoles = userRoles.keys
    
    allUsers.each do |user|
      modified = false
      
      # This user's roles have changed
      if usersWithRoles.include?(user.id.to_s)
        newRoles = userRoles[user.id.to_s]
        
        # Adds or removes roles as per new settings
        allRoles.each do |role|          
          modified ||= newRoles.include?(role.name) ? add_role(user, role.name) : remove_role(user, role.name)
        end
      else # This user has lost his roles if he had any before
        if user.has_roles?
          remove_all_roles(user)
          modified = true
        end
      end
      
      if modified
        @modifiedUsers << user
      end  
    end

    numModified = @modifiedUsers.size
    flash[:notice] = "#{numModified} user" + ((numModified > 1) ? "s' " : "'s ") + "roles have been modified"
    redirect_to users_path
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, :notice => "Successfully destroyed user \"#{@user.name}\"."
  end
  
  private
  
  def add_role user, roleName
    
    if !user.role? roleName
      role = Role.find(:first, :conditions => ['name = ?', roleName])
      
      userRole = UserRole.new(:user_id => user.id, :role_id => role.id)
      userRole.save!
      
      user.update_roles
    else
      return false
    end

  end
  
  def remove_role user, roleName

    if user.role? roleName
      role = Role.find(:first, :conditions => ['name = ?', roleName])
      
      userRole = UserRole.find(:first, :conditions =>['user_id = ? and role_id = ?', user.id, role.id])
      p "Found the userRole to delete = "
      p userRole.inspect
      userRole.destroy
      p "Ran destroy"
      
      user.update_roles
    else
      return false
    end
    
  end
  
  def add_all_roles user
    allRoles = Role.all

    allRoles.each {|role| add_role(user, role.name) }
  end
  
  def remove_all_roles user
    allRoles = Role.all
    
    allRoles.each {|role| remove_role(user, role.name) }
  end
end
