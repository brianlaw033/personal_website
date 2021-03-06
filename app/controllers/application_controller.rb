class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :new_bot_action

  def new_bot_action
    @bot_action = BotAction.new
  end

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:email,:password, :password_confirmation])
        devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :current_password, :password_confirmation, :avatar])
    end
end
