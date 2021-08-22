module API
    module Entities
        class Comments < Grape::Entity
            present_collection true
            expose :status_code, as: 'status'
            expose :items, as: 'data', using: API::Entities::Comment
            
            def status_code
                '200'
            end
        end        
    end
end