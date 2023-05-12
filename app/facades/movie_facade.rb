class MovieFacade
  attr_reader :id, :movie

  def initialize(id)
    @id = id
  end

  def movie
    TmdbService.new.get_movie(@id)
  end

  def poster_path
    "https://image.tmdb.org/t/p/w154#{@movie.poster_path}"
  end

  def movie_reviews
    TmdbService.new.get_reviews(@id)
  end

  def movie_cast
    TmdbService.new.get_cast(@id)
  end
end