class CommonPagesController < ApplicationController

  def home
    if logged_in?
      @post = current_user.posts.build
      @feed_posts = current_user.feed.paginate(page: params[:page])
    end
  end

  def about

  end

  def help

  end
end