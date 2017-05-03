module TicketsCase
    extend ActiveSupport::Concern
    include ActiveModel::Validations

    def complete
        raise NotImplementedError
    end

    def change_status
        raise NotImplementedError
    end

    def create
        raise NotImplementedError
    end

    def success?
        errors.none?
    end
end
