class MoviesController < ApplicationController
  skip_before_action :authenticate!, only: [ :show, :index ]
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
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movie_path(@movie)
  end

  def edit
    id = params[:id]
    @movie = Movie.find(id)
    @cancel_path = movie_path(@movie)
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
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "#{@movie.title} was successfully deleted."
    redirect_to movies_path
  end

  private
  def movie_params
    params.require(:movie).permit(:title, :rating, :release_date, :description)
  end
end
