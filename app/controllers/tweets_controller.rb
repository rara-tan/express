class TweetsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]

  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      redirect_to root_url
    else
      @tweets = current_user.tweets.order('created_at DESC').page(params[:page])
      render 'toppages/index'
    end
  end

  def destroy
    @tweet.destroy
    @tweets = current_user.tweets.order('created_at DESC').page(params[:page])
    render 'toppages/index'
  end
  
  def edit
  end

  def update
  end

  private

  def tweet_params
    params.require(:tweet).permit(:content)
  end
  
  def correct_user
    @tweet = current_user.tweets.find_by(id: params[:id])
    unless @tweet
      redirect_to root_url
    end
  end
end