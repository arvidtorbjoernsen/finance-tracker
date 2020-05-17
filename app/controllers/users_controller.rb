# frozen_string_literal: true

class UsersController < ApplicationController
  def my_portfolio
    @tracked_stocks = current_user.stocks
    @user = current_user
  end

  def my_friends
    @tracked_friends = current_user.friends
  end

  def show
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
  end

  def search
    if params[:friend].present?
      @friends = User.search(params[:friend])
      @friends = current_user.except_current_user(@friends)
      if @friends
        respond_to do |format|
          format.js { render partial: 'friends/result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = 'Could not find user'
          format.js { render partial: 'friends/result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = 'Please enter a friends name or email to search'
        format.js { render partial: 'friends/result' }
      end
    end
  end
end
