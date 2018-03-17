class RelationshipsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    user = User.find(params[:follow_id])
    if current_user.following?(user)
      flash[:danger] = 'すでにフォロー済みです。'
      redirect_to current_user
    else
      if current_user != user
        current_user.follow(user)
        flash[:success] = 'ユーザをフォローしました。'
        redirect_to user
      else
        flash[:danger] = '自分自身はフォローできません。'
        redirect_to current_user
      end
    end
  end

  def destroy
    user = User.find(params[:follow_id])
    if current_user.following?(user)
      current_user.unfollow(user)
      flash[:success] = 'ユーザのフォローを解除しました。'
      redirect_to current_user
    else
      flash[:danger] = 'フォローしておりません。'
      redirect_to current_user
    end
  end
end
