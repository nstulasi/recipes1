class SiteController < ApplicationController
  def index
    @title = "Recipes-U-Like"
  end
  def about
    @title = "About"
  end
end
