module GenerateUrl
    ALPHABET = ('a'..'z').to_a
    ALPHABET += ('A'..'Z').to_a
    N = 2
    def self.generate_link_id(ticket)
        ticket.link_id = create_url
        ticket.link_id = create_url while Ticket.find_by(link_id: ticket.link_id)
    end

    def self.create_url

        r = Random.new
        url = ""
        N.times do |i|
            url += 3.times.map {ALPHABET.sample}.join+"-"
            url += r.rand(100..999).to_s
            url += "-" unless i == N-1
        end
        url
    end
end
