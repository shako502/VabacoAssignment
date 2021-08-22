module API
    module Entities
        class Status < Grape::Entity
            expose :s_code, as: 'status' 
        end
    end
end