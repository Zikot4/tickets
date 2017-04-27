class Ticket < ApplicationRecord
    STATUSES = {
        'Waiting' => "Waiting For Reply",
        'Inprogress' => "In Progress",
        'Closed'=> "Closed"
    }

    has_many :comments, as: :commentable, dependent: :destroy
end
