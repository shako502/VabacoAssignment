require 'rails_helper'

describe "API::V1:Posts" do
    let!(:post_with_comments) { FactoryBot.create(:post_with_comments) }
    let(:post_id) { post_with_comments.id }
    let(:comments) { post_with_comments.comments }
    describe "GET /api/v1/posts/:post_id/comments" do
        context "get all comments on the post" do
            before { get "/api/v1/posts/#{post_id}/comments" }

            it "should return status code 200" do
                expect(response.status).to eq(200)
            end

            it "should return maximum of 10 last comments" do
                json_response = JSON.parse(response.body)
                expect(json_response["data"].size).not_to be_zero
                expect(json_response["data"].size).to be <= 10
            end

            it "should have json body with specified array keys" do
                json_response = JSON.parse(response.body)
                expect(json_response["data"].first.keys).to match_array(
                    ["id", "post_id", "body", "created_at"]
                )
            end

            it "should match FK to the post id" do
                json_response = JSON.parse(response.body)
                expect(json_response["data"].first["post_id"]).to eq(post_id)
            end

        end
    end

    describe "POST /api/v1/posts/:post_id/comments" do
        let(:comment_body) { Faker::ChuckNorris.fact }
        before do
            post "/api/v1/posts/#{post_id}/comments", params: {
                :body => comment_body
            }
        end
        context "add comment to the post" do
            it "should have response created(201)" do
                expect(response).to have_http_status(:created)
            end

            it "should match comment content to the DB comment_body" do
                json_response = JSON.parse(response.body)
                expect(json_response["data"]["body"]).to eq(comment_body)
            end
        end
    end

    describe "PUT /api/v1/posts/:post_id/comments/:comment_id" do
        let(:up_comment_body) { Faker::ChuckNorris.fact }
        before do
            put "/api/v1/posts/#{post_id}/comments/#{comments.first.id}", params: {
                :body => up_comment_body
            }
        end
        context "update comment on the post" do
            it "should have response status 200" do
                expect(response.status).to eq(200)
            end

            it "should match DB record to the newly updated comment" do
                json_response = JSON.parse(response.body)
                expect(json_response["data"]["body"]).to eq(up_comment_body)
            end
        end
    end

    describe "DELETE /api/v1/posts/:post_id/comments/:comment_id" do
        let(:random_comment) { comments[rand(comments.length)] }
        let(:r_comment_id) { random_comment.id }
        context "delete comment on the post" do
            before { delete "/api/v1/posts/#{post_id}/comments/#{r_comment_id}" }

            it "should have response status 200" do
                expect(response.status).to eq(200)
            end

            it "should be wiped off the face of the earth" do
                expect { random_comment.reload }.to raise_error(ActiveRecord::RecordNotFound)
            end
        end
    end
end