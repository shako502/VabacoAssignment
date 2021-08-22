module API
    module Entities
        class Posts < Grape::Entity
            present_collection true
            expose :status_code, as: 'status'
            expose :items, as: 'data', using: API::Entities::Post
            
            def status_code
                '200'
            end
        end        
    end
end