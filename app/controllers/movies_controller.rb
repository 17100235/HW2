class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = ['R','G','PG','NC-17','PG-13']
    if params[:ratings] != nil
      @movies = Movie.where(rating: params[:ratings].keys)
    else
    @movies = Movie.order(params[:sort_by])
    end
  end

  def new
    # default: render 'new' template
  end
  


  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end
  
  def updatemovie
 
  end
  
  def updatepls
       @movie = Movie.find_by_title(params[:oldmovie][:title])
     if @movie
      # @movie = Movie.find params[:id]
      @movie.update_attributes!(movie_params)
      flash[:notice] = "#{@movie.title} was successfully updated."
      redirect_to movie_path(@movie)
     else
       flash[:notice] = "THE TITLE WAS NOT A VALID MOVIE TITLE U SUCK"
       redirect_to movies_path
     end
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end
  
  def deletemovie
  end
  
  def deletepls
      @movie = Movie.find_by_title(params[:movie][:title])
       if @movie
        @movie.delete
        flash[:notice] = "#{@movie.title} was successfully deleted."
        redirect_to movies_path
       else 
         flash[:notice] = "This doesn't exist"
         redirect_to movies_path
       end
  end
  
  def deletemoviebyrating
  end
  
  def deleteplsrating
       
       while true
        @movie = Movie.find_by_rating(params[:movie][:rating])
        if @movie != nil
          @movie.destroy  
          # flash[:notice] = "Movies with rating #{@movie.rating} was/were successfully deleted."
          
        else 
         flash[:notice] = "This doesn't exist"
        # redirect_to movies_path
         break
        end
        
     end
     redirect_to movies_path
  end
  
  def all_ratings
  end

  
  

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
