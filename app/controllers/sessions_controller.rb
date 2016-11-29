class SessionsController < ApplicationController
  # Login session
  def new
  end

  def create
    user = User.find_by( :username => params[ :username ] )

    if user.present? && user.authenticate( params[ :password ] )
      flash[ :success ] = "You successfully logged in"
      session[ :user_id ] = user.id

      redirect_to( posts_path )
    else
      flash[ :error ] = "Wrong password or username"
      render :new
    end
  end

  # Logout session
  def destroy
    session[ :user_id ] = nil
    redirect_to( root_path )
  end

end
