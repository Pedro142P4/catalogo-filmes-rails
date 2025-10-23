class CommentsController < ApplicationController
  def create
    @movie = Movie.find(params[:movie_id])
    @comment = @movie.comments.build(comment_params)

    if user_signed_in?
      @comment.user = current_user
      @comment.name = current_user.email
    else
    end

    if @comment.save
      redirect_to movie_path(@movie), notice: "Comentário adicionado!"
    else
      redirect_to movie_path(@movie), alert: "Erro ao adicionar comentário."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :name)
  end
end
