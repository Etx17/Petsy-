class UsersController < ApplicationController

  # skip_before_action :only_signed_in, only: [:new, :create, :confirm]

  def new
    @user = User.new
  end

  def create
    # Récupérer les paramètres envoyés dans le form
    user_params = params.require(:user).permit(:username, :email, :password, :password_confirmation)
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      UserMailer.confirm(@user).deliver_now
      redirect_to new_user_path, success: 'Compte crée, vous devriez reçevoir un email de confirmation'
    else
      render 'new'
    end
  end

  def confirm
    print params
    @user = User.find(params[:id])
    # vérifier que le confirmation token passé en paramètre est dans la bdd
    if @user.confirmation_token == params[:token]
      @user.confirmed = true
      @user.confirmation_token = nil
      # .save() ne marcherait pas car on a modifié les attributs et dont ca passerait pas la validation.
      # Du coup on désactive la validation ici
      @user.save(validate: false)
      # Connecter l'utilisateur
      session[:auth] = @user.to_session
      session[:auth][:id] = @user.id
      redirect_to new_user_path, success: 'Votre compte a bien été confirmé'

    else
      redirect_to new_user_path, danger: 'Ce token ne semble pas valide'
    end
  end

  def edit
    @user = User.find(session[:auth]['id'])
    # Récupère les infos envoyées par l'utilisateur

  end

  def update
  end
end
