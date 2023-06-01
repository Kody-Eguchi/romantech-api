class OpenaiController < ApplicationController
  def generate_text
    api = OpenAI::Client.new(access_token: ENV['API_KEY'])

    user_input = params[:input]

    response = api.chat(
    parameters: {
        model: "gpt-3.5-turbo", # Required.
        messages: [{ role: "user", content: user_input}], # Required.
        temperature: 0.7,
    })

    if response.present? && response['choices'].present?
      generated_text = response['choices'].last['message']['content']
      render json: { generated_text: generated_text }
    else
      error_message = 'Error occurred while generating text'
      render json: { error: error_message }, status: :unprocessable_entity
    end
  end
end
