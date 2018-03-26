class ToppagesController < ApplicationController
  before_action :require_user_logged_in, only: [:search]

  def index
    if logged_in?
      @user = current_user
      @tweet = current_user.tweets.build
      @tweets = Tweet.where(user_id: current_user.followings.ids + [current_user.id]).order('created_at DESC').page(params[:page])
    end
  end

  def search
    @user = current_user
    @search_string = tweet_params[:search_string]
    @tweet = current_user.tweets.build
    @tweets_count = Tweet.where('content LIKE(?)', "%#{@search_string}%").count
    @tweets = Tweet.where('content LIKE(?)', "%#{@search_string}%").order('created_at DESC').page(params[:page])
  end

  private

  def tweet_params
    params.require(:tweet).permit(:search_string)
  end
end
