class PostsController < ApplicationController
  def index
    @posts = User.find_by( :id => params[ :user_id ] ).posts.order( created_at: :desc )
    @post = Post.new
  end

  def show
    # When viewing post, it shall be in the show all comments view
  end

  def create
    # TODO make sure to use the API Giphy / Gif generator
    # This will be used to crete new gif
    post = Post.new( post_params )
    post.user_id = @current_user.id
    post.save
    redirect_to( posts_path )
  end

  def edit
    @post = Post.new
  end

  def update
    post = Post.find_by( :id => params[ :id ] )
    post.update( post_params )

    redirect_to( user_posts_path( post.user) )
  end

  # TODO make sure to have this being implemented
  def destroy
    post = Post.find_by( :id => params[ :id ] )
    post.destroy

    redirect_to( user_posts_path( @current_user ) )
  end

  def show_all
    @posts = Post.order( created_at: :desc )
    @post = Post.new
  end

  private
    def post_params
      params.require( :post ).permit( :post_gif, :caption, :user_id )
    end

end
