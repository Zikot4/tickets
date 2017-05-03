class CommentsService
    include CommentsCase

    def initialize(ticket,user,params)
        @ticket = ticket
        @user = user
        @params = params
    end

    def create
        comment = @ticket.comments.new params
        comment.user_id = user.id if user.moderator or user.admin if user
        comment.save
        return comment
    end

private
    attr_reader :user, :ticket, :params
end
