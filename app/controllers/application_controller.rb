class ApplicationController < ActionController::Base
  # TODO : re enable the before action: only_signed in on the sessions and users controller.
  # before_action :only_signed_in
  add_flash_types :success, :danger

  private

  def only_signed_in
    if !session[:auth] || !session[:auth][:id]
      redirect_to new_user_path, danger: "Vous n'avez pas le droit d'accéder à cette page"
    end
  end
end
