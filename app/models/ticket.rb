require './app/service/tickets_service.rb'

class Ticket < ApplicationRecord
    STATUSES = {
        :waiting => "Waiting For Reply",
        :inprogress => "In Progress",
        :closed => "Closed"
    }
    has_many :comments, as: :commentable, dependent: :destroy

    @ticket_service = TicketService.new

    scope :uncompleted, lambda { where(complete: false).order('status DESC')}
    scope :completed, lambda {where(complete: true).order('updated_at DESC')}
    scope :inprogress, lambda {|user| where(moderator_id: user.id,status: STATUSES['Inprogress'])}

    def self.change_status(ticket, user)
        @ticket_service.change_status(ticket,user)
    end

    def self.complete(ticket)
        @ticket_service.complete(ticket)
    end

    def self.create_ticket(ticket,ticket_params)
        @ticket_service.create_ticket(ticket,ticket_params)
    end
end
