class ToppagesController < ApplicationController
  def index
    # ログインユーザのフォロワー分含めてtweetを取得
    if logged_in?
      @user = current_user
      @tweet  = @user.tweets.build
      @tweets = @user.tweets.order('created_at DESC').page(params[:page])
    end
  end
end
