class RatingsController < ApplicationController
 
 def create
	@recipe = Recipe.find(params[:recipe_id])

      @recipe.user_id = User.logged_in(session).id

	Rating.delete_all(["rateable_type = 'Recipe' AND rateable_id = 	? AND user_id = ?", @recipe.id, @recipe.user_id])

	@recipe.add_rating Rating.new(:rating => params[:rating],
	:user_id => @recipe.user_id)

	redirect_to @recipe
 end


end
