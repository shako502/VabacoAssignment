module API
    module Entities
        class Post < Grape::Entity
            expose :id
            expose :title
            expose :body
            expose :mark_for_deletion
            expose :created_at
        end
    end
end