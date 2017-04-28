class CommentsController < ApplicationController
    before_action :find_ticket
    before_action :ticket_is_closed?
    before_action :find_comment, only: [:destroy,:edit,:show,:update]

    def index
    end

    def show
    end

    def new
        @comment = Comment.create_comment(@ticket,@comment,current_user,comment_params)
        redirect_to ticket_path(@ticket.link_id), notice: "Your comment was successful posted."
    end

    def create
    end

    def update
		if @comment.update(params[:comment].permit(:body))
			redirect_to ticket_path(@ticket.link_id), notice: "Comment was successfully updated."
		else
			render 'edit'
		end
	end

    def destroy
        @comment.destroy
        redirect_to ticket_path(@ticket.link_id), notice: "Comment was successfully destroyed."
    end
private
    # Use callbacks to share common setup or constraints between actions.
    def find_comment
        @comment = @ticket.comments.find(params[:id])
    end

    def find_ticket
        @ticket = Ticket.find_by(link_id: params[:ticket_link_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body)
    end

    def ticket_is_closed?
        redirect_to root_path if @ticket.complete
    end

end