require 'faraday'


module TatusTask1Gem1
    class TokenAPI 
        BASE_URL = "https://dev-0erpan4x.us.auth0.com/"

        attr_reader :client_id, :client_secret, :adapter

        def is_not_valid(client_id, client_secret)
            return client_id.empty? || client_secret.empty?
        end

        def initialize(client_id:, client_secret:, adapter: Faraday.default_adapter)
            raise StandardError.new('wrong input data, exiting!') if is_not_valid(client_id, client_secret)
            @client_id = client_id
            @client_secret = client_secret
            @grant_type = 'client_credentials'
            @audience = 'https://athletedataservice.thesportsoffice.com'
            @adapter = adapter
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
            connection.post('/oauth/token') do |req|
                req.body = form_data
              end
        end

        def token
            response = post
            if response.status == 200 
                response.body['access_token']
            else
                puts "Could not get token, got status: #{response.status}"
            end 
        end

        def inspect
            "#<TatusTask1Gem1::TokenAPI>"
        end
    end
end