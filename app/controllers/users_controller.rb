class UsersController < ApplicationController

  def index
  end

  def show
    @user = User.find_by(username: params[:username]);
    @posts = Post.where(user_id: @user.id);
    @points = 0
    @posts.each do |post|
      @points += post.upvotes
    end
    @points < 1 ? @points_per_post = 0 : @points / @posts.count
  end

end
