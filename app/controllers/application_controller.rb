class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

def current_ability
  @current_ability ||= Ability.new(:user => current_user)
end

end