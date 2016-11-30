User.destroy_all
Post.destroy_all
Comment.destroy_all

u1 = User.create( {
  :username => "gucco",
  :name => "Gucco",
  :email => "gucco@ga.co",
  :profile_img => "https://twistedsifter.files.wordpress.com/2009/12/stormtrooper-line-art.jpg?w=495&h=495",
  :biography => "It's me, the real Gucco",
  :password => "chicken",
  :password_confirmation => "chicken"
} )

u2 = User.create( {
  :username => "southernface",
  :name => "The South Face",
  :email => "southface@ga.co",
  :profile_img => "http://vignette3.wikia.nocookie.net/lego/images/1/1a/Chewie.jpg/revision/latest?cb=20131031235204",
  :biography => "The Southern from the wello",
  :password => "chicken",
  :password_confirmation => "chicken"
} )

u3 = User.create( {
  :username => "starbutt",
  :name => "Starbutt",
  :email => "starbutt@ga.co",
  :profile_img => "https://mi-od-live-s.legocdn.com/r/www/r/catalogs/-/media/catalogs/characters/star%20wars/new%20full%20body/updated/75140_admiral-ackbar_mugshot_672x896.png?l.r2=1586324475",
  :biography => "Cheerful star with sparkly butt",
  :password => "chicken",
  :password_confirmation => "chicken"
} )

u4 = User.create( {
  :username => "smithens",
  :name => "The Smithens",
  :email => "smithens@ga.co",
  :profile_img => "https://mi-od-live-s.legocdn.com/r/www/r/catalogs/-/media/catalogs/characters/star%20wars/new%20full%20body/captain%20tarpals.png?l.r2=993879118",
  :biography => "Local Imaginery Band",
  :password => "chicken",
  :password_confirmation => "chicken"
} )

u5 = User.create( {
  :username => "bluekoi",
  :name => "The Remarkable Blue Koi",
  :email => "bluekoi@ga.co",
  :profile_img => "https://mi-od-live-s.legocdn.com/r/www/r/catalogs/-/media/catalogs/characters/star%20wars/new%20full%20body/updates%20june/mugshot-672x896_0014_poe.png?l.r2=710010615",
  :biography => "Yes, I am a Koi but actually not",
  :password => "chicken",
  :password_confirmation => "chicken"
} )

# ---------------

p1 = Post.create( {
  :caption => "Even if it takes me to wait for ages, I'm still diggin' it!",
  :post_gif => "http://i.giphy.com/100QWMdxQJzQC4.gif",
  :user_id => u3.id
} )

p2 = Post.create( {
  :caption => "Great coffee taste better when being shared",
  :post_gif => "http://i.giphy.com/2ma3lihYLznBm.gif",
  :user_id => u3.id
} )

p3 = Post.create( {
  :caption => "Ya damn right, brah!",
  :post_gif => "http://i.giphy.com/3oGRFp0AqM0BY4axjO.gif",
  :user_id => u1.id
} )

p4 = Post.create( {
  :caption => "This season better be coming quick",
  :post_gif => "http://i.giphy.com/9dF5VJahr4sBG.gif",
  :user_id => u2.id
} )
p5 = Post.create( {
  :caption => "You do know it's just around the corner...",
  :post_gif => "http://i.giphy.com/26gJz3pvlJsEAbJss.gif",
  :user_id => u4.id
} )
p6 = Post.create( {
  :caption => "Oh, hello there!",
  :post_gif => "http://i.giphy.com/fKNTlqx1hvfeE.gif",
  :user_id => u5.id
} )
p7 = Post.create( {
  :caption => "Seriously, this is how I look when running on the treadmill",
  :post_gif => "http://i.giphy.com/NRIT2SDViYasM.gif",
  :user_id => u4.id
} )
p8 = Post.create( {
  :caption => "It's nap time!",
  :post_gif => "http://i.giphy.com/xT8qB3iQFA5FXbszy8.gif",
  :user_id => u1.id
} )
p9 = Post.create( {
  :caption => "This sums me up right now",
  :post_gif => "http://i.giphy.com/uwfPLgaQvyNi0.gif",
  :user_id => u2.id
} )
p10 = Post.create( {
  :caption => "Every single morning be like...",
  :post_gif => "http://i.giphy.com/12sDN7sJ0TfmLe.gif",
  :user_id => u3.id
} )

u1.posts << p3 << p8
u2.posts << p4 << p9
u3.posts << p1 << p2 << p10
u4.posts << p5 << p7
u5.posts << p6

# ---------------------------

c1 = Comment.create( {
  :comment_post => "I feel you too, brah.",
  :user_id => u3.id,
  :post_id => p8.id
} )

c2 = Comment.create( {
  :comment_post => "I can relate...",
  :post_id => p10.id,
  :user_id => u2.id
} )

c3 = Comment.create( {
  :comment_post => "Totally agree!",
  :post_id => p2.id,
  :user_id => u5.id
} )

p8.comments << c1
p10.comments << c2
p2.comments << c3

users = User.all
user = users.first
following = users[ 1...5 ]
followers = users[ 2...5 ]

# User 1 following
following.each do | f |
  user.follow( f )
end
# User 1 follower
followers.each do | f |
  f.follow( user )
end
