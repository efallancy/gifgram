class UsersController < ApplicationController
  before_action :authorise, :only => [ :edit, :update ]

  def index
    @users = User.all
  end

  def show
    # TODO Need to change the params[ :id ] with sessions[ :user_id ]
    @user = @current_user
  end

  def edit
    # TODO Changed on to use the sessions[ :id ]
    @user = @current_user
  end

  def new
    @user = User.new
  end

  def create
    # TODO Make sure reference it with sessions
    @user = User.new( user_params )
    if @user.save
      session[ :user_id ] = @user.id
      redirect_to( edit_user_path )
    else
      render :new
    end
  end

  def update
    # TODO make sure to use current user
    user = @current_user
    if user.update( user_params )
      redirect_to user_path( user )
    else
      render :edit
    end
  end

  def destroy
    # TODO make sure to use current user
    user = @current_user
    user.destroy
    session[ :user_id ] = nil

    # TODO this shall redirect to logout
    redirect_to root_path
  end

  # Follow a user
  def follow( other_user )
    active_relationships.create( :followed_id => other_user.id )
  end

  # Unfollow a user
  def unfollow( other_user )
    active_relationships.find_by( :follower_id => other_user.id ).destroy
  end

  def following?( other_user )
    following.include?( other_user )
  end


  private
    def user_params
      params.require( :user ).permit( :name, :username, :email, :profile_img, :biography, :password, :password_confirmation )
    end

    # TODO Need to configure the redirect when login is failed
    def authorise
      if !@current_user.present?
        flash[ :error ] = "You will need to log in."
        #redirect_to
      end
    end

end
