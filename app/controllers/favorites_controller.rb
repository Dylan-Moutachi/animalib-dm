class FavoritesController < ApplicationController
  def index
    @favorites = current_user.favorites
  end

  def create
    @user = User.find(params[:user_id]) # c'est le pro
    @favorite = Favorite.new(professional: @user)
    @favorite.user = current_user
    if @favorite.save
      redirect_to user_path(@user)
    end
  end

  def destroy
    @user = User.find(params[:id])
    @favorite = Favorite.find_by(professional: @user, user: current_user)
    @favorite.destroy if @favorite

    if params[:source] == "favorites"
      redirect_to favorites_path, notice: "Favorite removed successfully"
    else
      redirect_to user_path(@user), notice: "Favorite removed successfully"
    end
  end
end
