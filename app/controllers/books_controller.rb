class BooksController < ApplicationController
  include ApplicationHelper
  
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    @books = Book.all.order('title asc')
    @order = 'asc'
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Retonar a lista de Livros filtrada e processada pronta para ser exibida
  def filtered
    @books = []
    if params.has_key? :filter and !params[:filter].empty?
      author_filter = Book.where("author like '%#{params[:filter]}%'")
      title_filter  = Book.where("title like '%#{params[:filter]}%'")
      description_filter = Book.where("description like '%#{params[:filter]}%'")

      author_filter.each do |author|
        @books << author
      end

      title_filter.each do |title|
        @books << title unless @books.include? title
      end

      description_filter.each do |description|
        @books << description unless @books.include? description
      end
    else
      @books = Book.all
    end

    respond_to do |format|
      format.html{render partial: 'books/book_list', locals: {books: @books}, layout: false}
      format.js  {render partial: 'books/book_list', locals: {books: @books}, layout: false}
    end
  end

  def sortby
    @order = (params[:order] == 'asc')? 'desc' : 'asc'
    @books = Book.all.order("#{params[:sort]} #{@order}")
    
    respond_to do |format|
      format.html{render partial: 'books/book_list', locals: {books: @books, order: @order}, layout: false}
      format.js  {render partial: 'books/book_list', locals: {books: @books, order: @order}, layout: false}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:author, :title, :description, :image)
    end
end
