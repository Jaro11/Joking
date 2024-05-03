class JokesController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'

  def show
    @joke = fetch_joke
  end

  private

  def fetch_joke
    uri = URI.parse("https://v2.jokeapi.dev/joke/Any")
    response = Net::HTTP.get_response(uri)
    return JSON.parse(response.body)["joke"] if response.is_a?(Net::HTTPSuccess)
  end
end
