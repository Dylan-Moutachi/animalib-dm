class AnimalsController < ApplicationController
  before_action :set_animal, only: [:update, :destroy]

  def index
    @animals = current_user.animals
    @animal = Animal.new
  end

  def new
    @animal = Animal.new
  end

  def create
    @animal = Animal.new(animal_params)
    @animal.user = current_user
    if @animal.save
      redirect_to @animal, notice: 'Animal was successfully created.'
    else
      render 'profiles/show'
    end
  end

  def edit
    @animal = Animal.find(params[:id])
  end

  def update
    if @animal.update(animal_params)
      redirect_to @animal, notice: 'Animal was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    set_animal
    @animal.destroy
    redirect_to profile_path, notice: 'Animal was successfully destroyed.'
  end

  private

  def set_animal
    @animal = Animal.find(params[:id])
  end

  def animal_params
    params.require(:animal).permit(:name, :birthdate, :specie, :breed, :user_id, :photo)
  end
end
