class CommentsController < ApplicationController
  def create
    post_id = params[:post_id].to_i
    post = Post.find(post_id)

    comment = post.comments.new(comments_params)
    comment.author = current_user

    respond_to do |format|
      format.html do
        if comment.save
          flash[:success] = 'Comment added!'
          redirect_back_or_to(post)
        else
          flash[:error] = 'Something went wrong'
          redirect_back_or_to(post)
        end
      end
    end
  end

  private

  def comments_params
    params.require(:comment).permit(:text)
  end
end
