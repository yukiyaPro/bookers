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
    end

    def create
        @book = Book.new(book_params)
        if @book.save
          redirect_to @book, notice: 'Book was successfully created'

        else
            render :index
        end
    end

    def edit
        @book = Book.find(params[:id])
    end

    def update
        @book = Book.find(params[:id])
        if @book.update(book_params)
          redirect_to @book, notice: 'Book was successfully created'

        else
            render :index
        end
    end

    def destroy
        @book = Book.find(params[:id])
        if @book.destroy
            redirect_to books_path
        else
            redirect_to :back
        end
    end

    private
    def book_params
        params.require(:book).permit(:title,:body).merge(user_id: current_user.id)
    end
end
