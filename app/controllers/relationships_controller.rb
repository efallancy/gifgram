class RelationshipsController < ApplicationController
  before_action :fetch_user
  def create
    user = User.find_by( :id => params[ :followed_id ] )
    @current_user.follow( user )
    redirect_to user_posts_path( user )
  end

  def destroy
    user = Relationship.find_by( :id => params[ :id ] ).followed
    @current_user.unfollow( user )
    redirect_to user_posts_path( user )
  end
end
