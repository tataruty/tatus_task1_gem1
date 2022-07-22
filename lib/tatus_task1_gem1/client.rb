require 'faraday'

module TatusTask1Gem1
    class Client 
        def initialize(client_id:, client_secret:, adapter: Faraday.default_adapter)
            @token_client = TatusTask1Gem1::TokenClient.new(client_id: client_id, client_secret: client_secret)
            token = @token_client.token
            raise StandardError.new('nil token, exiting!') if token.nil?
            @athletes_client = TatusTask1Gem1::AthletesClient.new(token: token)
        end

        def all_athletes
            @athletes_client.athletes
        end

        def inspect
            "#<TatusTask1Gem1::Client>"
        end
    end
end