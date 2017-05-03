class TicketsService
    include TicketsCase

    def initialize(ticket, user, params)
        @ticket = ticket
        @user = user
        @params = params
    end

    def change_status
        if ticket.status == Ticket::STATUSES[:waiting]
            ticket.status = Ticket::STATUSES[:inprogress]
            ticket.moderator_id = user.id
            ticket.save
        end
    end

    def complete
        ticket.complete = true
        ticket.status = Ticket::STATUSES[:closed]
        ticket.save
    end

    def create
        @ticket = Ticket.new(params)
        generate_url
        #send_url_by_email
        ticket.save
        return ticket
    end
private
    attr_reader :ticket, :user, :params

    def generate_url
        GenerateUrl.generate_link_id(ticket)
    end

    def send_url_by_email
        SecreturlMailer.secreturl_send(ticket).deliver
    end

end
