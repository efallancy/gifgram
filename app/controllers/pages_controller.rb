class PagesController < ApplicationController
  def home
    req = HTTParty.get( "http://api.giphy.com/v1/gifs/trending?api_key=dc6zaTOxFJmzC" )
    @req = req[ "data" ]
  end

  def about
  end

end
