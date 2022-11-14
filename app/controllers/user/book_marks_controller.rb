class User::BookMarksController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    book_mark = current_user.book_marks.new(post_id: post.id)
    book_mark.save
    redirect_to post_path(post.id)
  end

  def destroy
    post = Post.find(params[:post_id])
    book_mark = current_user.book_marks.find_by(post_id: post.id)
    book_mark.destroy
    redirect_to post_path(post.id)
  end

end
