require 'faraday'

module TatusTask1Gem1
    class Client 
        def initialize(client_id:, client_secret:, adapter: Faraday.default_adapter)
            @token_api = TatusTask1Gem1::TokenAPI.new(client_id: client_id, client_secret: client_secret)
            token = @token_api.token
            raise StandardError.new('nil token, exiting!') if token.nil?
            @athletes_api = TatusTask1Gem1::AthletesAPI.new(token: token)
        end

        def all_athletes
            @athletes_api.athletes
        end

        def inspect
            "#<TatusTask1Gem1::Client>"
        end
    end
end