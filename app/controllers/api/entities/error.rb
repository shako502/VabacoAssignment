module API
    module Entities
        class Error < Grape::Entity
            expose :error_code
        end
    end
end