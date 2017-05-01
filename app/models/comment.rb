require './app/service/comments_service.rb'
class Comment < ApplicationRecord
    belongs_to :commentable, polymorphic: true

    @commnet_service = CommentService.new

    def self.create_comment(ticket,comment,user,comment_params)
        @commnet_service.create_comment(ticket,comment,user,comment_params)
    end
end
