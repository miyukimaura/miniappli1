class TweetsController < ApplicationController

  before_action :move_to_index, except: :index

  def index
    @tweets = Tweet.page(params[:page]).per(5).order("created_at DESC")
  end

  def new
  end

  def create
    Tweet.create(tweet_params)
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy if tweet.user_id == current_user.id
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end
  

  private
  def tweet_params
    params.permit(:name, :image, :text)
  end
  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

end