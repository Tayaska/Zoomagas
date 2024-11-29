class RegistrationsController < ApplicationController
  # Метод для створення нового користувача (відображення форми реєстрації)
  def new
    @user = User.new
  end

  # Метод для обробки реєстрації нового користувача
  def create
    @user = User.new(user_params)

    if @user.save
      # Автоматична автентифікація після реєстрації
      user = User.authenticate_by(user_params.permit(:email_address, :password))
      start_new_session_for(user)
      redirect_to after_authentication_url, notice: "Account successfully registered!"
    else
      # Якщо валідація не пройшла, повернути форму з помилками
      render :new, status: :unprocessable_entity
    end
  end

  private

  # Метод для безпечного отримання параметрів користувача
  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation)
  end
end
