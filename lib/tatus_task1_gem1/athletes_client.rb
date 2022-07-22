require 'faraday'
require 'active_support/all'

module TatusTask1Gem1
    class AthletesClient 
        BASE_URL = "https://athletedataservice.azurewebsites.net"
        attr_reader :token, :adapter

        def is_valide(token)
            return !token.empty?
        end

        def initialize(token:, adapter: Faraday.default_adapter)
            raise StandardError.new('empty token, exiting!') if !is_valide(token)
            @token = token
            @adapter = adapter
        end

        def connection
            @connection ||= Faraday.new(
                url: BASE_URL,
                headers: {'Content-Type' => 'application/x-www-form-urlencoded'}
              ) do |conn|
                conn.response :json
                conn.request :url_encoded
                conn.request :authorization, 'Bearer', @token
                conn.adapter adapter
              end 
        end 

        def athletes
            connection.get('summary').body
        end

        def inspect
            "#<TatusTask1Gem1::AthletesClient>"
        end
    end
end