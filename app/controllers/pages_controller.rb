class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]
  before_action :set_user, only: [:index]
  def home
  end

  def dashboard
    @recipes = current_user.created_recipes
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
  
end
