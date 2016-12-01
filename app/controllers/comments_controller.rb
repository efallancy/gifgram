class CommentsController < ApplicationController

  def index
    @post = Post.find_by( :id => params[ :post_id ] )
    @comments = @post.comments.order( created_at: :desc )
    @comment = Comment.new
    @templates = templates
  end

  # TODO double confirm on this thing
  def show
  end

  def create

    comment = Comment.new

    if params[ :file ].present?
      req = Cloudinary::Uploader.upload( params[ :file ] )
      comment.comment_post = req[ 'public_id' ]
    end

    comment.user_id = @current_user.id
    comment.post_id = params[ :post_id ]
    comment.save

    post = comment.post_id
    user = comment.user_id

    redirect_to( user_post_comments_path( :user_id => user, :post_id => post ) )

  end

  def create_magic_touch
    comment = Comment.new

    if params[ :file ].present?
      req = Cloudinary::Uploader.upload( params[ :file ] )

      img_with_text = Cloudinary::Uploader.text( params[ :top_text ],
                                                 :public_id => req[ 'public_id' ],
                                                 :font_family => "Roboto",
                                                 :font_size => 42,
                                                 :font_color => "black",
                                                 :font_weight => "bold" )

      comment.comment_post = img_with_text[ 'secure_url' ]
    end

    user = @current_user.id
    post = params[ :post_id ]

    comment.post_id = post
    comment.user_id = user

    if comment.save
      redirect_to( user_post_comments_path( :user_id => user, :post_id => post  ) )
    else
      render :index
    end
  end

  def create_mainstream

    top_text = params[ :top_text ]
    bottom_text = params[ :bottom_text ]
    template_id = params[ :template_id ]
    link = template_links[ template_id.to_i - 1 ]

    response = HTTParty.get( link + "/#{ top_text }/#{ bottom_text }" )

    img = response["direct"]["masked"]


    comment = Comment.new
    comment.comment_post = img
    comment.user_id = @current_user.id
    comment.post_id = params[ :post_id ]
    comment.save

    user = @current_user.id
    post = params[ :post_id ]

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

    def templates
      [
        [ "10 Guy", 1 ],
        [ "Afraid to Ask Andy", 2 ],
        [ "An Older Code Sir, But It Checks Out", 3 ],
        [ "Ancient Aliens Guy", 4 ],
        [ "Baby Insanity Wolf", 5 ],
        [ "Bad Luck Brian", 6 ],
        [ "But That's None of My Business", 7 ],
        [ "Butthurt Dweller", 8 ],
        [ "Captain Hindsight", 9 ],
        [ "Comic Book Guy", 10 ],
        [ "Condescending Wonka", 11 ],
        [ "Confession Bear", 12 ],
        [ "Conspiracy Keanu", 13 ],
        [ "Dating Site Murderer", 14 ],
        [ "At Least You Tried", 15 ],
        [ "Do It Live!", 16 ],
        [ "Do You Want Ants?", 17],
        [ "Doge", 18],
        [ "Drake Always On Beat", 19],
        [ "Ermahgerd", 20],
        [ "Facepalm", 21],
        [ "First World Problems", 22],
        [ "Forever Alone", 23],
        [ "Foul Bachelor Frog", 24],
        [ "Fuck Me, Right?", 25],
        [ "Futurama Fry", 26],
        [ "Good Guy Greg", 27],
        [ "Hipster Barista", 28],
        [ "I Can Has Cheezburger?", 29],
        [ "I Feel Like I'm Taking Crazy Pills", 30],
        [ "I Guarantee It", 31]
      ]
    end

    def template_links
      [
        "https://memegen.link/api/templates/tenguy",
        "https://memegen.link/api/templates/afraid",
        "https://memegen.link/api/templates/older",
        "https://memegen.link/api/templates/aag",
        "https://memegen.link/api/templates/biw",
        "https://memegen.link/api/templates/blb",
        "https://memegen.link/api/templates/kermit",
        "https://memegen.link/api/templates/bd",
        "https://memegen.link/api/templates/ch",
        "https://memegen.link/api/templates/cbg",
        "https://memegen.link/api/templates/wonka",
        "https://memegen.link/api/templates/cb",
        "https://memegen.link/api/templates/keanu",
        "https://memegen.link/api/templates/dsm",
        "https://memegen.link/api/templates/tried",
        "https://memegen.link/api/templates/live",
        "https://memegen.link/api/templates/ants",
        "https://memegen.link/api/templates/doge",
        "https://memegen.link/api/templates/alwaysonbeat",
        "https://memegen.link/api/templates/ermg",
        "https://memegen.link/api/templates/facepalm",
        "https://memegen.link/api/templates/fwp",
        "https://memegen.link/api/templates/fa",
        "https://memegen.link/api/templates/fbf",
        "https://memegen.link/api/templates/fmr",
        "https://memegen.link/api/templates/fry",
        "https://memegen.link/api/templates/ggg",
        "https://memegen.link/api/templates/hipster",
        "https://memegen.link/api/templates/icanhas",
        "https://memegen.link/api/templates/crazypills",
        "https://memegen.link/api/templates/mw",
      ]
    end

end
