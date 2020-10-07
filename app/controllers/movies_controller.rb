class MoviesController < ApplicationController
  def index
    @movie = Movie.all
    @movies = @movie.order('title')
    @cancel_path = movies_path
  end

  def show
    id = params[:id]
    begin
      @movie = Movie.find(id)
      @cancel_path = movie_path(@movie)
    rescue ActiveRecord::RecordNotFound
      redirect_to movies_path
    end
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
    params.require(:movie).permit(:title, :rating, :release_date)
  end
end
