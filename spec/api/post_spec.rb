require 'rails_helper'

describe "API::V1::Posts" do

    let!(:posts) {FactoryBot.create_list(:post, 12)}
    let(:post_id) { posts.first.id }

    describe "GET /api/v1/posts/:post_id" do
        context "get the posts" do
            before { get "/api/v1/posts" }

            it "should return status 200" do
                expect(response.status).to eq(200)
            end

            it "should return only last 10 posts" do
                json_response = JSON.parse(response.body)
                expect(json_response["data"].size).to eq(10) 
            end
        end

        context "get single post" do
            before { get "/api/v1/posts/#{post_id}" }
            it "should return status 200" do
                json_response = JSON.parse(response.body)
                expect(json_response["status"]).to eq("200")
            end

            it "should have json body with specified array keys" do
                json_response = JSON.parse(response.body)
                expect(json_response["data"].keys).to match_array(
                    ["id", "title", "body", "mark_for_deletion", "created_at"]
                )
            end

            it "should match post id to the db id" do
                json_response = JSON.parse(response.body)
                post_data = json_response["data"]
                expect(post_data["id"]).to eq(post_id)
            end
        end
    end
end