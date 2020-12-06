class BooksController < ApplicationController
  before_action :authenticate_user!
    def index
        @books = Book.all.order("id DESC").includes(:user)
        @new_book = Book.new
        @user = current_user
    end

    def show
        @book = Book.find(params[:id])
        @new_book = Book.new
        @user = @book.user
        @new_comment = BookComment.new
        @comments = @book.book_comments.includes(:user)
    end

    def create
        @new_book = Book.new(book_params)
        if @new_book.save
          redirect_to @new_book, notice: 'Book was successfully created'

        else
           render :index
        end
    end

    def edit
        @book = Book.find(params[:id])
        if @book.user_id != current_user.id
            redirect_to books_path
        end
    end

    def update
        @book = Book.find(params[:id])
        if @book.update(book_params)
            redirect_to @book, notice: 'Book was successfully created'
        else
            render :edit
        end
    end

    def destroy
        @book = Book.find(params[:id])
        if @book.destroy
            redirect_to books_path
        else
            render :edit
        end
    end

    private
    def book_params
        params.require(:book).permit(:title,:body).merge(user_id: current_user.id)
    end
end
