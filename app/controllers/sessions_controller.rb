class SessionsController < ApplicationController

  # skip_before_action :only_signed_in, only: [:new, :create]

  def new

  end

  def create
    # "On ne fait pas de permit car les infos sont rentrées manuellement"
    user_params = params.require(:user)
    # Récupérer l'utilisateur dans la bdd qui a pour email ou pseudo le params entré.
    # TODO.: ca marche avec l'email mais pas l'username...
    @user = User.where(username: user_params[:username]).or(User.where(email: user_params[:username])).first
    print @user, "this is user"
    if @user && @user.authenticate(user_params[:password])
      session[:auth] = @user.to_session
      redirect_to profil_path, success: 'Connexion réussie'

    else
      redirect_to new_session_path, danger: 'Identifiant incorrect'
      print ' connexion échouée'
    end
  end

  def destroy
  end
end
