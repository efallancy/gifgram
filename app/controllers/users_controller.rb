class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    # TODO Need to change the params[ :id ] with sessions[ :user_id ]
    @user = User.find_by( :id => params[ :id ] )
  end

  def edit
    # TODO Changed on to use the sessions[ :id ]
    @user = User.find_by( :id => params[ :id ] )
  end

  def new
    @user = User.new
  end

  def create
    # TODO Make sure reference it with sessions
    user = User.new( user_params )
    user.save
  end

  def update
    # TODO make sure to use current user
    user = User.find( params[ :id ] )
    user.update( user_params )
    redirect_to user_path( user )
  end

  def destroy
    # TODO make sure to use current user
    user = User.find( params[ :id ] )
    user.destroy

    # TODO this shall redirect to logout
    redirect_to users_path
  end


  private
    def user_params
      params.require( :user ).permit( :name, :username, :email, :profile_img, :biography )
    end

    # TODO Need to configure the redirect when login is failed
    def authorise
      if !@current_user.present?
        flash[ :error ] = "You will need to log in."
        #redirect_to
      end
    end

end
