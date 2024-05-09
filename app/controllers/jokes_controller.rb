require 'net/http'

class JokesController < ApplicationController
  def show
    @joke = fetch_joke
    respond_to do |format|
      format.html # continues to respond to HTML requests as before
      format.json { render json: { joke: @joke } } # respond to JSON requests
    end
  end

  private

  def fetch_joke
    uri = URI.parse("https://v2.jokeapi.dev/joke/Any")
    response = Net::HTTP.get_response(uri)
    if response.is_a?(Net::HTTPSuccess)
      JSON.parse(response.body)["joke"]
    else
      puts "Failed to fetch joke: #{response.code} #{response.message}"
      nil
    end
  rescue JSON::ParserError => e
    puts "JSON Parsing Error: #{e.message}"
  rescue => e
    puts "General Error: #{e.message}"
  end

end
