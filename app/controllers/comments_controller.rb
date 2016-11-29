class CommentsController < ApplicationController
  def index
    @post = Post.find_by( :id => params[ :post_id ] )
    @comments = @post.comments.order( :created_at )
    @comment = Comment.new
  end

  # TODO double confirm on this thing
  def show
  end

  def create
    comment = Comment.new( comment_params )
    comment.user_id = @current_user.id
    comment.post_id = params[ :post_id ]
    comment.save

    post = comment.post_id
    user = comment.user_id

    redirect_to( user_post_comments_path( :user_id => user, :post_id => post ) )

  end

  # TODO this still need to be done properly
  def edit
  end

  # TODO make sure this is aligned with edit (above)
  def update
  end

  # TODO Ensure to have this delete comment method available
  def destroy
    comment = Comment.find_by( :id => params[ :id ] )
    comment.destroy
    redirect_to( user_post_comments_path( :user_id => params[ :user_id ], :post_id => params[ :post_id ] ) )
  end

  private
    def comment_params
      params.require( :comment ).permit( :comment_post, :user_id, :post_id )
    end

end
