module API
    module Entities
        class Comment < Grape::Entity
            expose :id
            expose :post_id
            expose :body
            expose :created_at
        end
    end
end