require 'rails_helper'

describe DuplicatesController, :type => :controller do
    describe "duplicates checker" do
        context "main page" do
            it "staying alive and returns status 200" do
                get :index
                expect(response.status).to eq(200)
            end
        end
        
        
        context ":create request" do
            before { post :create, :params => {:textToCount => "SomeTextToTest", :format => :json } }
            it "responds with lovely json and UTF8 is set" do
                expect(response.content_type).to eq "application/json; charset=utf-8"
            end

            it "response json is formatted correctly" do
                json_response = JSON.parse(response.body)
                expect(json_response.keys).to match_array(["count", "result"])
            end
        end

        shared_examples 'count_duplicates' do |string_tests|
            it "should match predefined result" do
                string_tests.each do |s_test|
                    post :create, :params => {:textToCount => s_test["word"], :format => :json }
                    json_response = JSON.parse(response.body)
                    expect(json_response["count"]).to eq(s_test["expected"])
                end
            end
        end

        context "is counting correctly" do
            test_cases = [
                { "word" => "abcde",   "expected" => 0}, 
                { "word" => "aabbcde", "expected" => 2},
                { "word" => "aabBcde", "expected" => 2},
                { "word" => "indivisibility", "expected" => 1},
                { "word" => "Indivisibilities", "expected" => 2},
                { "word" => "aA11", "expected" => 2},
                { "word" => "ABBA", "expected" => 2}
            ]
            include_examples 'count_duplicates', test_cases
        end
        
    end
end