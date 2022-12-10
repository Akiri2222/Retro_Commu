class User::GenresController < ApplicationController

  def index
    @genres = Genre.all
  end

  def show
    @genres = Genre.all
    @genre = Genre.find(params[:id])
    @tags = Tag.all
  end

end
