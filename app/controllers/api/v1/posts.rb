module API
    module V1
        class Posts < Grape::API
            include API::V1::Defaults

            resource :posts do
                # GET /api/v1/posts
                # -- Get Last 10 Posts
                desc "Return last 10 posts mark_for_deletion=false order by created_at DESC"
                get "" do
                    posts_res = Post.where("mark_for_deletion" => false).limit(10)
                    .order(created_at: :desc)
                    
                    #data = {'status': 200, 'data': posts_res}
                    #render json: posts_res, serializer: PostSerializer
                    present posts_res, with: API::Entities::Posts
                   
                end
            
                # GET /api/v1/posts/:id
                # -- Get Single Post
                desc "Return Single Post on specified ID"
                params do
                    requires :id, type: String, desc: "ID of the post"
                end
                get ":id" do
                    single_post = Post.where(id: permitted_params[:id]).first!
                    present single_post, with: API::Entities::Posts
                end

                # GET /api/v1/posts/:post_id/comments
                # -- Get Last 10 Comments on Post 
                desc "All comments for post"
                params do
                    requires :id, type: String, desc: "ID of the post"
                end
                get ":id/comments", root: "post" do
                    comments_res = Post.find(params[:id])
                    .comments
                    .limit(10)
                    .order(created_at: :desc)
                    #{'status': 200, 'data': comments_res}
                    present comments_res, with: API::Entities::Comments
                end

                # POST /api/v1/posts/:post_id/comments
                # -- Add comment to Single Post
                desc "Add comment on single post"
                params do
                    optional :post_id, type: String, desc: "ID of the post"
                    requires :body, type: String, desc: "Comment content"
                end
                post ":id/comments", root: "post" do
                    @posts_res = Post.find(params[:id])
                    @comments_res = @posts_res.comments.new({post_id:params[:post_id], body:params[:body]})
                    if @comments_res.save
                        present @comments_res, with: API::Entities::Comments
                    else
                        present e, with: API::Entities::Error, error_code: 500
                    end
                end


                # PUT /api/v1/posts/:post_id/comments/:comment_id
                # -- Update comment by ID
                desc "Update comment on single post by comment ID"
                params do
                    requires :comment_id, type: Integer, desc: "ID of the comment"
                    requires :body, type: String, desc: "New comment content"
                end

                put ":id/comments/:comment_id", root: "post" do
                    post_id = params[:id]
                    comment_id = params[:comment_id]
                    post_res = Post.find(post_id)
                    comment_up = post_res.comments.find(comment_id)

                    if comment_up.update({body: params[:body]})
                        present comment_up, with: API::Entities::Comments
                    else
                        present e, with: API::Entities::Error, error_code: 500
                    end
                end


                # DELETE /api/v1/posts/:post_id/comments/:comment_id
                # -- Delete comment by ID
                desc "Delete comment on single post by comment ID"
                params do
                    requires :post_id, type: Integer, desc: "ID of the post"
                    requires :comment_id, type: Integer, desc: "ID of the comment"
                end

                delete ":post_id/comments/:comment_id", root: "post" do
                    post_id = params[:post_id]
                    comment_id = params[:comment_id]
                    post_res = Post.find(post_id)
                    comment_del = post_res.comments.find(comment_id)
                    comment_del.destroy

                    if comment_del.destroyed?()
                        s_result = {s_code: "200"}
                        present s_result, with: API::Entities::Status
                    else
                        present e, with: API::Entities::Error, error_code: 500
                    end
                end
            end
        end
    end
end