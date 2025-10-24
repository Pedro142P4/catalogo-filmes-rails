class MoviesController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_movie, only: [ :show, :edit, :update, :destroy ]
  before_action :authorize_owner!, only: [ :edit, :update, :destroy ]

  def index
  @categories = Category.order(:name)
  @directors = Movie.select(:director).distinct.order(:director).pluck(:director).compact
  @years = Movie.select(:release_year).distinct.order(release_year: :desc).pluck(:release_year).compact

  @movies = Movie.includes(:categories).order(created_at: :desc)

  if params[:query].present?
    sql_query = "movies.title ILIKE :query OR movies.director ILIKE :query OR CAST(movies.release_year AS TEXT) ILIKE :query"
    @movies = @movies.where(sql_query, query: "%#{params[:query]}%")
  end

  if params[:category_id].present?
    @movies = @movies.joins(:categories).where(categories: { id: params[:category_id] })
  end

  if params[:director].present?
    @movies = @movies.where(director: params[:director])
  end

  if params[:release_year].present?
    @movies = @movies.where(release_year: params[:release_year])
  end

  @movies = @movies.page(params[:page]).per(6)
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
    params.require(:movie).permit(:title, :synopsis, :release_year, :duration, :director, :poster, { category_ids: [] }, :tag_list)
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
