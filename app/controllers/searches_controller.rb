class SearchesController < ApplicationController
  require 'httparty'

  def index
    @response = session[:response]
    session.delete(:response)
  end

  def create
    keywords = [params[:keyword_1], params[:keyword_2], params[:keyword_3]].join(" ")
  
    response = HTTParty.post(
      "https://api.openai.com/v1/chat/completions",
      headers: {
        "Authorization" => "Bearer #{ENV['OPENAI_API_SECRET_KEY']}",
        "Content-Type" => "application/json"
      },
      body: {
        messages: [
          {
            role: 'system',
            content: 'You are a helpful assistant.'
          },
          {
            role: 'user',
            content: keywords
          }
        ],
        max_tokens: 50,
        model: "gpt-4-1106-preview"
      }.to_json
    )
    Rails.logger.info "API Response: #{response.parsed_response}"
    session[:response] = response.parsed_response
    redirect_to action: :index
  end
  
end
