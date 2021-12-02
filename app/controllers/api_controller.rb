class ApiController < ApplicationController
    

    def test_api_consumer
        MessagePublisher.subsrice_event
        render json: {"hello": "world"}
    end
end