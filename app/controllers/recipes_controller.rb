class RecipesController < ApplicationController
  before_filter :protect
  # GET /recipes
  # GET /recipes.xml
  def index
        @user = User.logged_in(session)
    @recipes = Recipe.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @recipes }
      format.rss { render :layout => false }
    end
  end
  
  def all_recipes
    @recipes = Recipe.all
    respond_to do |format|
      format.html # all_recipes.html.erb
      format.xml  { render :xml => @recipes }
      format.rss { render :layout => false }
    end
  end  
  

  # GET /recipes/1
  # GET /recipes/1.xml
  def show
    @recipe = Recipe.find(params[:id])
    @recipe.user_id = User.logged_in(session).id
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @recipe }
    end
  end

  # GET /recipes/new
  # GET /recipes/new.xml
  def new  
    
    @recipe = Recipe.new
    

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @recipe }
    end
  end

  # GET /recipes/1/edit
  def edit
    @recipe = Recipe.find(params[:id])
  end

  # POST /recipes
  # POST /recipes.xml
  def create
    @recipe = Recipe.new(params[:recipe])
     @recipe.user_id = User.logged_in(session).id

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to(@recipe, :notice => 'Recipe was successfully created.') }
        format.xml  { render :xml => @recipe, :status => :created, :location => @recipe }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @recipe.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /recipes/1
  # PUT /recipes/1.xml
  def update
    @recipe = Recipe.find(params[:id])

    respond_to do |format|
      if @recipe.update_attributes(params[:recipe])
        format.html { redirect_to(@recipe, :notice => 'Recipe was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @recipe.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.xml
  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to(recipes_url) }
      format.xml  { head :ok }
    end
    
  end
  
  private
  # Protect a page against not logged users
  def protect
    unless User.logged_in?(session)
      flash[:notice] = "Please login first"
      redirect_to :controller => :user, :action => :login
      return false
    end
  end

end



