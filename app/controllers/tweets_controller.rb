class TweetsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy, :update]

  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      flash[:success] = 'ツイートしました。'
      redirect_to root_url
    else
      @tweets = Tweet.where(user_id: current_user.followings.ids + [current_user.id]).order('created_at DESC').page(params[:page])
      flash[:danger] = 'ツイートに失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @tweet.destroy
    flash[:success] = 'ツイートを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    @tweet = Tweet.find(params[:id])
    if @tweet.update(tweet_params)
      flash[:success] = 'ツイートが更新されました。'
      redirect_to root_url
    else
      flash.now[:danger] = 'ツイートは更新されませんでした。'
      render :edit
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:content, :image)
  end
  
  def correct_user
    @tweet = current_user.tweets.find_by(id: params[:id])
    unless @tweet
      redirect_to root_url
    end
  end
end
