class BookCommentsController < ApplicationController
  def index

  end

  def create
    @comment = BookComment.new(comment_params)
    if current_user
      if @comment.save
        redirect_to book_path(@comment.book), notice: "Create Book comment"
      else
        redirect_back(fallback_location: root_path)
      end
    else
      redirect_back(fallback_location: root_path)
    end
  end

    def edit
      @book = BookComment.find(params[:id]).book
      if current_user
        @comment = BookComment.find(params[:id])
      else
        redirect_back(fallback_location: root_path)
      end
    end

    def update
        @comment = BookComment.find(params[:id])
      if current_user
        if @comment.update(comment_params)
          redirect_to book_path(@comment.book), notice: "Update Book comment"
        else
          render 'edit'
        end
      end
    end

    def destroy
        @comment = BookComment.find(params[:id])
      if current_user
        if @comment.destroy
            redirect_to book_path(@comment.book), notice:'Destroy Book comment.'
        else
           redirect_back(fallback_location: root_path)
        end
      else
        redirect_back(fallback_location: root_path)
      end
    end

    private
    def comment_params
      params.require(:book_comment).permit(:comment,:book_id).merge(user_id: current_user.id)
    end
end
