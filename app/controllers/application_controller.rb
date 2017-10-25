class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_user_can_edit?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update) { |u|
      u.permit(:password, :password_confirmation, :current_password)
    }
  end

  def current_user_can_edit?(model)
    user_signed_in? &&
      (model.user == current_user ||
        (model.try(:event).present? && model.event.user == current_user))
  end

  def get_emails(event, model)
    event_emails = (event.subscriptions.map(&:user_email) + [event.user.email]).uniq
    event_emails -= [model.user.email] if model.user
  end
end
