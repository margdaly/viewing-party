class TmdbService
  def search_by_title(key_word)
    get_url("/3/search/movie?query=#{key_word}")
  end

  def top_rated_movies
    get_url('/3/movie/top_rated')
  end

  def get_movie(movie_id)
    get_url("/3/movie/#{movie_id}")
  end

  def get_cast(movie_id)
    get_url("/3/movie/#{movie_id}/credits")
  end

  def get_reviews(movie_id)
    get_url("/3/movie/#{movie_id}/reviews")
  end

  private
  
  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.themoviedb.org") do |f|
      f.params['api_key'] = ENV['tmdb_key']
      f.params['language'] = 'en-US'
    end
  end
end