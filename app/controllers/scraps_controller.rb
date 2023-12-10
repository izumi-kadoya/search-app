require 'httparty'

class ScrapsController < ApplicationController
  def index
    if search_params_present?
      api_key = ENV['GOOGLE_API_KEY']
      cse_id = ENV['GOOGLE_CSE_ID']
      keywords = [params[:keyword_1], params[:keyword_2], params[:keyword_3]].join(' ')

      response = HTTParty.get("https://www.googleapis.com/customsearch/v1", query: {
        key: api_key,
        cx: cse_id,
        q: keywords
      })

      @results = response.parsed_response if response.code == 200
    end
  end

  private

  def search_params_present?
    params[:keyword_1].present? || params[:keyword_2].present? || params[:keyword_3].present?
  end
end
