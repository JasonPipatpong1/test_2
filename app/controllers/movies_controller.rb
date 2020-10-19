class MoviesController < ApplicationController
  skip_before_action :authenticate!, only: [ :show, :index, :new, :edit, :destroy]
  def index
    @movie = Movie.all
    @movies = @movie.order('title')
    @cancel_path = movies_path
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    render(:partial => 'movie', :object => @movie) if request.xhr?
    # will render app/views/movies/show.<extension> by default
  end

  def new
    if set_current_user
      @movie = Movie.new
    else
      flash[:warning] = "Please log in before use this feature"
      redirect_to movies_path
    end
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movie_path(@movie)
  end

  def edit
    if set_current_user
      id = params[:id]
      @movie = Movie.find(id)
      @cancel_path = movie_path(@movie)
    else
      flash[:warning] = "Please log in before use this feature"
      redirect_to movies_path
    end
  end

  def update
    @movie = Movie.find(params[:id])
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    respond_to do |client_wants|
      client_wants.html { redirect_to movies_path }
      client_wants.xml { render :xml => @movie.xml }
    end
  end

  def destroy
    if set_current_user
      @movie = Movie.find(params[:id])
      @movie_title_delete = @movie.title
      @movie.destroy
      flash[:notice] = "#{@movie_title_delete} was successfully deleted."
      redirect_to movies_path
    else
      flash[:warning] = "Please log in before use this feature"
      redirect_to movies_path
    end
  end

  def search_tmdb
    @search_params = params[:search_terms]
    @search_params = " " if @search_params  == ""
    @search = Tmdb::Movie.find(@search_params)
    @search.each do |movie|
      if Movie.exists?(:title => movie.title, :description => movie.overview) == false
        create_tmdb(movie)
      end
    end

    if @search != []
      render "show_tmdb"
    else
      flash[:warning] = "'#{params[:search_terms]}' was not found in TMDb."
      redirect_to movies_path
    end

  end

  def create_tmdb(movie)
    permitted = {:title => movie.title,:rating =>"G" ,:release_date =>movie.release_date,:description => movie.overview}
    @movie = Movie.create!(permitted)
  end

  def show_tmdb
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    render(:partial => 'movie', :object => @movie) if request.xhr?
  end

  private
  def movie_params
    params.require(:movie).permit(:title, :rating, :release_date, :description)
  end
end
