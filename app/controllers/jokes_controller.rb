require 'net/http'
require 'uri'

class JokesController < ApplicationController
  def show
    category = params[:category] || "Any"
    blacklist_flags = params[:blacklistFlags] || ""
    @joke = fetch_joke(category, blacklist_flags)
    respond_to do |format|
      format.html # Render HTML for initial page load or if JavaScript is disabled
      format.json { render json: { joke: @joke || "No joke found, please try again!" } }
    end
  end

  private

  def fetch_joke(category, blacklist_flags)
    uri = URI("https://v2.jokeapi.dev/joke/#{category}?blacklistFlags=#{blacklist_flags}")
    response = Net::HTTP.get_response(uri)
    if response.is_a?(Net::HTTPSuccess)
      body = JSON.parse(response.body)
      body["joke"] || "#{body["setup"]} #{body["delivery"]}"
    else
      Rails.logger.info "Failed to fetch joke: #{response.code} #{response.message}"
      nil
    end
  rescue JSON::ParserError => e
    Rails.logger.error "JSON Parsing Error: #{e.message}"
    nil
  rescue => e
    Rails.logger.error "General Error: #{e.message}"
    nil
  end
end
