class RegistrationsController < ApplicationController
  # Метод для створення нового користувача (відображення форми реєстрації)
  def new
    @user = User.new
  end

  # Метод для обробки реєстрації нового користувача
  def create
    @user = User.new(user_params)

    if @user.save
      # Автоматичне увійдення користувача
      sign_in(@user)
      redirect_to after_sign_in_path_for(@user), notice: "Account successfully registered!"
    else
      render :new, status: :unprocessable_entity
    end
  end


  private

  # Метод для безпечного отримання параметрів користувача
  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation)
  end
end
