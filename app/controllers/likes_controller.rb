class LikesController < ApplicationController
  before_action :require_user_logged_in

  def create
    tweet = Tweet.find(params[:tweet_id])
    current_user.like(tweet)
    flash[:success] = 'ツイートにいいねしました。'
    redirect_back(fallback_location: root_path)
  end
  
  def destroy
    tweet = Tweet.find(params[:tweet_id])
    current_user.unlike(tweet)
    flash[:success] = 'ツイートのいいねを取り消ししました。'
    redirect_back(fallback_location: root_path)
  end
end
