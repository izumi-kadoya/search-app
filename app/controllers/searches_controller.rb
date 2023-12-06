class SearchesController < ApplicationController
  require 'httparty'

  def index
  end



  def create
    # ユーザーからのキーワードを取得
    keywords = [params[:keyword_1], params[:keyword_2], params[:keyword_3]].join(" ")

    # OpenAI APIにリクエストを送信
    response = HTTParty.post(
      "https://api.openai.com/v1/engines/davinci-codex/completions",
      headers: {
        "Authorization" => "Bearer #{ENV['OPENAI_API_KEY']}",
        "Content-Type" => "application/json"
      },
      body: {
        prompt: keywords,
        max_tokens: 100,
        model: "gpt-4"
      }.to_json
    )

    # レスポンスをビューに渡す
    @response = response.parsed_response

    render 'show'
  end
end

end
