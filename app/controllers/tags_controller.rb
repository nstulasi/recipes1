class TagsController < ApplicationController
  
  def show
	@recipes = Recipe.find_tagged_with(params[:id])
  end

end
