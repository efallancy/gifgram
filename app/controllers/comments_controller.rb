class CommentsController < ApplicationController
  def index
    @post = Post.find_by( :id => params[ :post_id ] )
    @comment = @post.comments.new
    # @comments = Comment.find_by( :post_id => params[ :post_id ] )
  end

  # TODO double confirm on this thing
  def show
  end

  def create
    comment = Comment.new( comment_params )
    comment.user_id = params[ :user_id ]
    comment.post_id = params[ :post_id ]
    comment.save
    # binding.pry
    post = comment.post_id
    user = comment.user_id

    redirect_to user_post_comments_path( :user_id => user, :post_id => post )
  end

  # TODO this still need to be done properly
  def edit
  end

  # TODO make sure this is aligned with edit (above)
  def update
  end

  # TODO Ensure to have this delete comment method available
  def destroy
  end

  private
    def comment_params
      params.require( :comment ).permit( :comment_post, :user_id, :post_id )
    end

end
