class UsersController < ApplicationController
  def my_portfolio
    @user = current_user
    @tracked_stocks = current_user.stocks
  end
  def my_friends
    @friends = current_user.friends
  end
  def show
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
  end
  def search
    if params[:friend].present?
      @friends = User.search(params[:friend])
      @friends = current_user.except_current_user(@friends)

      respond_to do |format|
        if @friends
          format.js
          format.html { render "users/my_friends" }
        else
          flash.now[:alert] = "Friend not found. Please enter a valid email or name to search."
          format.js
          format.html { render "users/my_friends" }
        end
      end
    else
      flash.now[:alert] = "Please enter a friend email or name to search."

      respond_to do |format|
        format.js
        format.html { render "users/my_friends" }
      end
    end
  end
end
