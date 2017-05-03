class Ticket < ApplicationRecord
    STATUSES = {
        :waiting => "Waiting For Reply",
        :inprogress => "In Progress",
        :closed => "Closed"
    }
    has_many :comments, as: :commentable, dependent: :destroy

    scope :uncompleted, lambda { where(complete: false).order('status DESC')}
    scope :completed, lambda {where(complete: true).order('updated_at DESC')}
    scope :inprogress, lambda {|user| where(moderator_id: user.id,status: STATUSES[:inprogress])}

end
