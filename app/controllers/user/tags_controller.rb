class User::TagsController < ApplicationController

  def show
    @tag = Tag.find(params[:id])
    @genres = Genre.all
    @tags = Tag.all
  end

end
