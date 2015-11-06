class CommentsController < ApplicationController

	def new
		@user=current_user
		@comment = Comment.new
	end

	def create  
	  @user = current_user
	  @comment = Comment.new(comment_params)
	  @comment.user_id = current_user.id

	  if @comment.save
	    flash[:success] = "Comment posted!"
	    redirect_to :back
	  else
	    flash[:alert] = "Error in your comments."
	    render root_path
	  end
	end

	def destroy  
	  @comment = @post.comments.find(params[:id])

	  @comment.destroy
	  flash[:success] = "Comment deleted."
	  redirect_to root_path
	end

	private

	def comment_params  
	  params.require(:comment).permit(:body, :post_id, :user_id)
	end

end