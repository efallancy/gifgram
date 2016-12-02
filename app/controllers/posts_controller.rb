class PostsController < ApplicationController
  def index
    @user = User.find_by( :id => params[ :user_id ] )
    @posts = @user.posts.order( created_at: :desc )
    @post = Post.new
  end

  def show
    # When viewing post, it shall be in the show all comments view
  end

  def create
    post = Post.new

    if params[ :file ].present?
      req = Cloudinary::Uploader.upload( params[ :file ] )
      post.post_gif = req[ 'public_id' ]
    end

    post.caption = post_params[ :caption ]
    post.user_id = @current_user.id
    post.save

    redirect_to( posts_path )
  end

  def create_random_post

     userid = params[ :user_id ]

     link = "http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC"
     req = HTTParty.get( link )

     giphy = req[ "data" ][ "image_original_url" ]

     quotelink = "http://api.forismatic.com/api/1.0/?method=getQuote&format=json&lang=en"
     req_quote = HTTParty.get( quotelink )
     quoteCaption = req_quote[ "quoteText" ]

     post = Post.new
     post.user_id = userid
     post.post_gif = giphy
     post.caption = quoteCaption
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
