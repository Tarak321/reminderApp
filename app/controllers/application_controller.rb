class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> {request.format.json?}
  # before_action :validates_user!, except: [:login,:logout,:sessions]


  # helper_method :current_user
  # def current_user
  #   if session[:user_id]
  #     @current_user ||= User.find(session[:user_id])
  #   else
  #     @current_user = nil
  #   end
  # end
  private
  def validates_user!
    if request.headers['Authorization'].present?
      # {'Authorization' : 'Bearer <TOKEN>'}
      token = request.headers["Authorization"]
      token = token.split(" ")[1]  # Remove "Bearer"

      begin 
        jwt_payload = JWT.decode(token, Rails.application.secrets.secret_key_base).first
        @current_user_id = jwt_payload['id']

      rescue => exception 
        head :unauthorized
      end
    else 
      head :unauthorized
    end
  end
end
