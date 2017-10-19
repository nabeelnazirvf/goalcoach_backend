class CommentsController < ApplicationController
  before_action :set_comment_service

  # GET /comments
  def index
    result = @comment_service.index(params[:goal_id])
    if result[:success]
      render json: result[:data], include: ['comments']
    else
      render json: { error: result[:error] }, status: :unprocessable_entity
    end
  end

  # POST /comments
  def create
    result = @comment_service.create(comment_params)
    if result[:success]
      render json: result[:data], include: ['comment']
    else
      render json: { error: result[:error] }, status: :unprocessable_entity
    end
  end

  def all_comments
    render json: Comment.all, include: ['comments']
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment_service
      @comment_service = CommentService.new
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      if params[:comment].present?
        params.require(:comment).permit(:text, :goal_id, :user_id)
      else
        nil
      end
    end
end
