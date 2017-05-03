module TicketsCase
    extend ActiveSupport::Concern
    include ActiveModel::Validations

    module ClassMethods
        def complete(*args)
            new(*args).tap { |use_case| use_case.perform }
        end
        def create(*args)
            new(*args).tap { |use_case| use_case.perform }
        end
    end

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
