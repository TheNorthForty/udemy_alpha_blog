class PagesController < ApplicationController
  def home
    render html: 'Hello World, from the alpha-blog!'
  end
  def about
  end
end
