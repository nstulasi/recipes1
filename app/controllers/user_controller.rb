class UserController < ApplicationController

  before_filter :protect, :except => [:login, :register, :tech]

  def index
    @title = "User Index"
    @user = User.logged_in(session)
  end

  def register
    @title = "Register"

    if request.post?
      @user = User.new(params[:user])
      if @user.save
        @user.login!(session)
        flash[:notice] = "User with login #{@user.screen_name} created!"
        redirect_to :controller => "recipes", :action => "all_recipes" 
      end
    end
  end

  def login
    @title = "Log in to Recipes-U-Like"
  
    if request.post?
      user = User.find_by_screen_name_and_password(params[:user][:screen_name], params[:user][:password])
      if user
        user.login!(session)
        flash[:notice] = "User #{user.screen_name} logged in"
        redirect_to :controller => "recipes", :action => "all_recipes" 
      else
        flash[:notice] = "Invalid email/password combination"
      end
    end
  end

  def logout
    flash[:notice] = "User " + User.logged_in(session).screen_name + " logged out"
    User.logout!(session)
    redirect_to :controller => :site, :action => :index
  end
  
  def edit
    @title = "Edit Your Details"
    @user = User.logged_in(session)
    if request.post?
      if @user.update_attributes(params[:user])
        flash[:notice] = "Your details have been updated"
        redirect_to :action => :index
      end
    end
    @user.password = nil
    @user.password_confirmation = nil
  end

  def profile
    @screen_name = params[:id]
    @title = "User Profile for #{@screen_name}"
    @user = User.find_by_screen_name(@screen_name)
  end

  def find_by_town
    @town = params[:id]
    @title = "All people from #{@town}"
    @users = User.find(:all, :conditions => "town = '#{@town}'")
  end

private
  # Protect a page against not logged users
  def protect
    unless User.logged_in?(session)
      flash[:notice] = "Please login first"
      redirect_to :action => :login
      return false
    end
  end
end

