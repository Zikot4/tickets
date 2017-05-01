class CommentService
    def create_comment(ticket,comment,user,comment_params)
        comment = ticket.comments.new comment_params
        comment.user_id = user.id if user.moderator or user.admin if user
        comment.save
        return comment
    end
end
