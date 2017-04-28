class Ticket < ApplicationRecord
    STATUSES = {
        'Waiting' => "Waiting For Reply",
        'Inprogress' => "In Progress",
        'Closed'=> "Closed"
    }
    has_many :comments, as: :commentable, dependent: :destroy

    scope :uncompleted, lambda { where(complete: false).order('status DESC')}
    scope :completed, lambda {where(complete: true).order('updated_at DESC')}
    scope :inprogress, lambda {|user| where(moderator_id: user.id,status: STATUSES['Inprogress'])}

    def self.change_status(ticket, user)
        if ticket.status == STATUSES['Waiting']
            ticket.status = STATUSES['Inprogress']
            ticket.moderator_id = user.id
            ticket.save
        end
    end

    def self.complete(ticket)
        ticket.complete = true
        ticket.status = Ticket::STATUSES['Closed']
        ticket.save
    end

    def self.create_ticket(ticket,ticket_params)
        ticket = self.new(ticket_params)
        GenerateUrl.generate_link_id(ticket)
        ticket.save
        #SecreturlMailer.secreturl_send(ticket).deliver
        return ticket
    end



end
