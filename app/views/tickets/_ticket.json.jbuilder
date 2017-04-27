json.extract! ticket, :link_id, :title, :body, :email, :created_at, :updated_at
json.url ticket_url(ticket.link_id, format: :json)
