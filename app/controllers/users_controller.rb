class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.order('created_at DESC').page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザ登録に失敗しました。'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :introduction, :password, :password_confirmation)
  end
end
