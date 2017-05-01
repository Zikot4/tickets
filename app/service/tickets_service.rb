require_relative 'module/generate_url'
class TicketService
    def change_status(ticket,user)
        if ticket.status == Ticket::STATUSES[:waiting]
            ticket.status = Ticket::STATUSES[:inprogress]
            ticket.moderator_id = user.id
            ticket.save
        end
    end

    def complete(ticket)
        ticket.complete = true
        ticket.status = Ticket::STATUSES[:closed]
        ticket.save
    end

    def create_ticket(ticket,ticket_params)
        ticket = Ticket.new(ticket_params)
        GenerateUrl.generate_link_id(ticket)
        ticket.save
        #SecreturlMailer.secreturl_send(ticket).deliver
        return ticket
    end
end
