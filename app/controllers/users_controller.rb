class UsersController < ApplicationController

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
end
