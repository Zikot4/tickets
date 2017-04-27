class SecreturlMailer < ApplicationMailer

    def secreturl_send(ticket)
        mail    to: ticket.email,
                from: "ticket@example.com",
                subject: "Create ticket",
                body: "Your secret url is: http:/localhost:3000/tickets/"+ticket.link_id.to_s
    end
end
