class CommentsController < ApplicationController
    before_action :find_ticket
    before_action :find_comment, only: [:destroy, :edit, :show, :update]
    before_action :init_service, only: [:new]
    before_action :ticket_completed?, only: [:new, :edit, :update, :destroy]

    def index
    end

    def show
        authorize! :show, @comment
    end

    def new
        @comment_service.create
        redirect_to ticket_path(@ticket.link_id), notice: "Your comment was successful posted."
    end

    def create
    end

    def edit
        authorize! :update, @comment
    end

    def update
		if @comment.update(params[:comment].permit(:body))
			redirect_to ticket_path(@ticket.link_id), notice: "Comment was successfully updated."
		else
			render 'edit'
		end
	end

    def destroy
        authorize! :destroy, @comment
        @comment.destroy
        redirect_to ticket_path(@ticket.link_id), notice: "Comment was successfully destroyed."
    end
private
    # Use callbacks to share common setup or constraints between actions.
    def find_comment
        @comment = @ticket.comments.find_by(id: params[:id])
    end

    def init_service
        @comment_service = CommentsService.new(@ticket,current_user,comment_params)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body)
    end

    def find_ticket
        @ticket = Ticket.find_by(link_id: params[:ticket_link_id])
    end

    def ticket_completed?
        authorize! :completed?, @ticket
    end

end
