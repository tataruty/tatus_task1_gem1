# frozen_string_literal: true
require('spec_helper')
require('./lib/tatus_task1_gem1')


RSpec.describe(::TatusTask1Gem1::TokenAPI) do
    let(:client_id) { 'test' }
    let(:client_secret) { 'client_secret' }
    let(:grant_type) { 'client_credentials' }
    let(:audience) { 'https%3A%2F%2Fathletedataservice.thesportsoffice.com' }
    let(:access_token) { 'real-test-token' }
    let(:argument_file) { 'spec/fixtures/token.json' }
    let(:expected_body) { JSON.parse(File.read(argument_file)) }
    
    let(:login_response) do
      {   access_token: "real-test-token",
          scope: "read:summary",
          expires_in: 86400,
          token_type: "Bearer"
        }.to_json
    end
  
    describe('#initialize happy path') do
      subject(:token) { described_class.new(client_id: client_id, client_secret: client_secret) }

      before do
        stub_request(:post, "https://dev-0erpan4x.us.auth0.com/oauth/token").
           with(
             body: {"audience"=>"https://athletedataservice.thesportsoffice.com", "client_id"=>"test", "client_secret"=>"client_secret", "grant_type"=>"client_credentials"},
             headers: {
             'Content-Type'=>'application/x-www-form-urlencoded',
             }).to_return(status: 200, body: login_response, headers: {'Content-Type'=>'application/json'})
      end

      it('token body response') do
        expect(token.post.body).to eq(expected_body)
      end

      it('get token value') do
        expect(token.token).to eq(access_token)
      end

      it('inspect token') do
        expect(token.inspect).to eq("#<TatusTask1Gem1::TokenAPI>")
      end
  end

  describe('#initialize bad response') do
    subject(:token) { described_class.new(client_id: client_id, client_secret: client_secret) }
  
    before do
      stub_request(:post, "https://dev-0erpan4x.us.auth0.com/oauth/token").
         with(
           body: {"audience"=>"https://athletedataservice.thesportsoffice.com", "client_id"=>"test", "client_secret"=>"client_secret", "grant_type"=>"client_credentials"},
           headers: {
           'Content-Type'=>'application/x-www-form-urlencoded',
           }).to_return(status: 400, body: nil, headers: {})
    end

    it('get 400 response') do
      expect(token.token).to be_nil
    end
  end 

  describe('#initialize bad input') do
      it { expect { described_class.new(client_id: client_id, client_secret: "") }.to raise_error(StandardError) }
  end 
end 
  