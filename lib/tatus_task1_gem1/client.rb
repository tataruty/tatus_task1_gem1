require 'faraday'
require 'active_support/all'

module TatusTask1Gem1
    class Client 
        BASE_URL = "https://dev-0erpan4x.us.auth0.com/"
        attr_reader :client_id, :client_secret, :grant_type, :audience, :adapter

        def is_valide(client_id, client_secret, grant_type, audience)
            if client_id.empty? || client_secret.empty? || grant_type.empty? || audience.empty?
                false
                else
                    true
                end
        end

        def initialize(client_id:, client_secret:, grant_type:, audience:, adapter: Faraday.default_adapter)
            if is_valide(client_id, client_secret, grant_type, audience)
            @client_id = client_id
            @client_secret = client_secret
            @grant_type = grant_type
            @audience = audience
            @adapter = adapter
            else
                puts 'wrong input data, exiting!'
                exit!
            end
        end

        
        private def form_data
            {
                client_id: @client_id,
                client_secret: @client_secret,
                grant_type: @grant_type,
                audience: @audience
            }
          end

        def connection
            @connection ||= Faraday.new(
                url: BASE_URL,
                headers: {'Content-Type' => 'application/x-www-form-urlencoded'}
              ) do |conn|
                conn.response :json
                conn.request :url_encoded
                conn.adapter adapter
              end 
        end 

        def post 
            @response = connection.post('/oauth/token') do |req|
                req.body = form_data
              end
        end

        def print_token
            @response = post
            if @response.status == 200 
                @response.body['access_token']
            else
                "Could not get token, got status: #{@response.status}"
            end 
        end

        def inspect
            "#<TatusTask1Gem1::Client>"
        end
    end
end