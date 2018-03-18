class ToppagesController < ApplicationController
  def index
    if logged_in?
      @user = current_user
      @tweet = current_user.tweets.build
      @tweets = Tweet.where(user_id: current_user.followings.ids + [current_user.id]).order('created_at DESC').page(params[:page])
    end
  end
end
