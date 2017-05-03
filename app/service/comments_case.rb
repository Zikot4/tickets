module CommentsCase
    extend ActiveSupport::Concern
    include ActiveModel::Validations

    module ClassMethods
        def create(*args)
            new(*args).tap { |use_case| use_case.perform }
        end
    end

    def create
        raise NotImplementedError
    end

    def success?
        errors.none?
    end
end
