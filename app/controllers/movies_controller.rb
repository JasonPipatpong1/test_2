class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.html.haml by default
  end

  def new
    @movie = Movie.new
    # default : render 'new ' template
  end

  def create
    params.require(:movie)
    params[:movie].permit(:title,:rating,:release_date)

    movie_1 = {:title => 'test', :rating => 'G',
      :release_date => '25-Nov-2000'}
    # @movie = Movie.create!(movie_1)      
    
    test01 = params[:movie]

    movie01 = {:title => test01["title"], :rating => test01["rating"],
      :release_date => "#{test01["release_date(1i)"]}-#{test01["release_date(2i)"]}-#{test01["release_date(3i)"]}"}

    # flash[:notice] = "#{movie_1} #{params[:movie]} #{@movie}"

    @movie = Movie.create!(movie01)
    flash[:notice] = "#{test01["title"]} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    getParamMovie = params[:movie]
    movie01 = {:title => getParamMovie["title"], :rating => getParamMovie["rating"],
      :release_date => "#{getParamMovie["release_date(1i)"]}-#{getParamMovie["release_date(2i)"]}-#{getParamMovie["release_date(3i)"]}"}
    
    @movie.update_attributes!(movie01)    
    # flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
      
end