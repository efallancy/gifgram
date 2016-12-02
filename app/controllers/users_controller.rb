class UsersController < ApplicationController
  before_action :authorise, :only => [ :edit, :update ]

  def index
    @users = User.all
  end

  def show
    @user = User.find_by( :id => params[ :id ] )
  end

  def edit
    @user = @current_user
  end

  def new
    @user = User.new
  end

  def create

    @user = User.new( user_params )
    if @user.save
      session[ :user_id ] = @user.id
      redirect_to( user_path( @user ) )
    else
      render :new
    end
  end

  def update

    user = @current_user

    if params[ :file ].present?
      req = Cloudinary::Uploader.upload( params[ :file ] )
      user.profile_img = req[ 'public_id' ]
    end

    user.assign_attributes( user_params )

    if user.save
      redirect_to user_path( user )
    else
      render :edit
    end
  end

  def destroy

    user = @current_user
    user.destroy
    session[ :user_id ] = nil

    redirect_to root_path
  end

  private
    def user_params
      params.require( :user ).permit( :name, :username, :email, :profile_img, :biography, :password, :password_confirmation )
    end

    def authorise
      if !@current_user.present?
        flash[ :error ] = "You will need to log in."
        #redirect_to
      end
    end

end
