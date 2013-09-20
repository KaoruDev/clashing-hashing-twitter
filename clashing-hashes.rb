require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'twitter'
require_relative 'lib/follower_clash'


get '/' do
  erb :index
end

post '/results' do
  @user1 = FollowerClash::User.new(params[:loginA])
  @user2 = FollowerClash::User.new(params[:loginB])
  @result = FollowerClash::Comparer.new(@user1, @user2).compare
  erb :results
end

post '/my-tweets' do
  @user1 = FollowerClash::User.new('devkaoru')
  @tweets = @user1.my_tweets
  erb :tweets
end

post '/tweet' do
  @user1 = FollowerClash::User.new('devkaoru')
  @tweet = @user1.tweet(params[:tweet])
  erb :post_tweet
end