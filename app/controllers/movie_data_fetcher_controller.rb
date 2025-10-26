require "httparty"

class MovieDataFetcherController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :fetch ], raise: false

  def fetch
    title = params[:title]
    api_key = Rails.application.credentials.tmdb_api_key

    language = (I18n.locale == :'pt-BR' ? "pt-BR" : "en-US")

    if title.blank?
      return render json: { success: false, error: "Movie title cannot be blank." }, status: :bad_request [cite: 49]
    end
    if api_key.blank?
      return render json: { success: false, error: "API Key not configured." }, status: :internal_server_error [cite: 49]
    end

    begin
      search_url = "https://api.themoviedb.org/3/search/movie?api_key=#{api_key}&query=#{ERB::Util.url_encode(title)}&language=#{language}"
      search_response = HTTParty.get(search_url, timeout: 5)

      unless search_response.success? && search_response.parsed_response["results"].present?
        return render json: { success: false, error: "Movie not found or API error during search." }, status: :not_found [cite: 49]
      end

      movie_id = search_response.parsed_response["results"][0]["id"]

      details_url = "https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{api_key}&append_to_response=credits&language=#{language}"
      details_response = HTTParty.get(details_url, timeout: 5)

      unless details_response.success?
        return render json: { success: false, error: "Failed to fetch movie details from TMDb." }, status: :unprocessable_entity [cite: 49]
      end

      data = details_response.parsed_response
      synopsis = data["overview"]
      release_year = data["release_date"] ? data["release_date"].split("-")[0].to_i : nil
      duration = data["runtime"]

      director = data.dig("credits", "crew")&.find { |person| person["job"] == "Director" }&.[]("name")

      render json: {
        success: true,
        movie: {
          synopsis: synopsis,
          release_year: release_year,
          duration: duration,
          director: director
        }
      }

    rescue HTTParty::Error, Net::OpenTimeout, SocketError => e
      render json: { success: false, error: "Failed to connect to TMDb API: #{e.message}" }, status: :service_unavailable [cite: 49]
    rescue StandardError => e
      render json: { success: false, error: "An unexpected error occurred." }, status: :internal_server_error [cite: 49]
    end
  end
end
