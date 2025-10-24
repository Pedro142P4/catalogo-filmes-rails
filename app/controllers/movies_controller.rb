class MoviesController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_movie, only: [ :show, :edit, :update, :destroy ]
  before_action :authorize_owner!, only: [ :edit, :update, :destroy ]

  def index
    @movies = Movie.order(created_at: :desc).page(params[:page]).per(6)
  end

  def show
    @comments = @movie.comments.order(created_at: :desc)
    @comment = Comment.new
  end

  def new
    @movie = Movie.new
    @categories = Category.all
  end

  def create
    @movie = current_user.movies.build(movie_params)
    if @movie.save
      redirect_to root_path, notice: "Filme cadastrado com sucesso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @categories = Category.all
  end

  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: "Filme atualizado com sucesso!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @movie.destroy
    redirect_to root_path, notice: "Filme apagado com sucesso!", status: :see_other
  end

  private
  def movie_params
    params.require(:movie).permit(:title, :synopsis, :release_year, :duration, :director, :poster, category_ids: [])
  end

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def authorize_owner!
    unless @movie.user == current_user
      redirect_to root_path, alert: "Você não tem permissão para esta ação."
    end
  end
end
