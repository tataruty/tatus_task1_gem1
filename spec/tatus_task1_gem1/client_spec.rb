# frozen_string_literal: true
require('spec_helper')
require('./lib/tatus_task1_gem1')


RSpec.describe(::TatusTask1Gem1::Client) do
    let(:client_id) { 'test' }
    let(:client_secret) { 'client_secret' }
    let(:access_token) { 'real-test-token' }
    let(:athletes_file) { 'spec/fixtures/athletes_response.json' }
    let(:expected_athletes_body) { JSON.parse(File.read(athletes_file),symbolize_names: true) }
    # let(:token_file) { 'spec/fixtures/token.json' }
    # let(:token_body) { JSON.parse(File.read(token_file)).to_s }
    let(:token_response) do
        {   access_token: "real-test-token",
            scope: "read:summary",
            expires_in: 86400,
            token_type: "Bearer"
          }.to_json
      end
  
    describe('#initialize happy path') do
      subject(:client) { described_class.new(client_id: client_id, client_secret: client_secret) }

      before do
        stub_request(:post, "https://dev-0erpan4x.us.auth0.com/oauth/token").
               with(
                 body: {"audience"=>"https://athletedataservice.thesportsoffice.com", "client_id"=>"test", "client_secret"=>"client_secret", "grant_type"=>"client_credentials"},
                 headers: {
                 'Content-Type'=>'application/x-www-form-urlencoded',
                 }).to_return(status: 200, body: token_response, headers: {'Content-Type'=>'application/json'})

        stub_request(:get, "https://athletedataservice.azurewebsites.net/summary").
         with(
           headers: {
       	  'Authorization'=>'Bearer real-test-token',
       	  'Content-Type'=>'application/x-www-form-urlencoded',
           }).to_return(status: 200, body: expected_athletes_body, headers: {})
      end

      it('init happy path') do
        athletes = client.all_athletes
        expect(athletes).not_to be_empty
        expect(athletes.dig(1,:summary,1,:value)).to eq(98)
        expect(athletes.length()).to eq(3)
      end

      it('inspect client') do
        expect(client.inspect).to eq("#<TatusTask1Gem1::Client>")
      end
  end

  let(:nil_token_response) do
    {   access_token: nil,
        scope: "read:summary",
        expires_in: 86400,
        token_type: "Bearer"
      }.to_json
  end

  describe('#negative tests') do
    subject(:client) { described_class.new(client_id: client_id, client_secret: client_secret) }

    before do
      stub_request(:post, "https://dev-0erpan4x.us.auth0.com/oauth/token").
             with(
               body: {"audience"=>"https://athletedataservice.thesportsoffice.com", "client_id"=>"test", "client_secret"=>"client_secret", "grant_type"=>"client_credentials"},
               headers: {
               'Content-Type'=>'application/x-www-form-urlencoded',
               }).to_return(status: 200, body: nil_token_response, headers: {'Content-Type'=>'application/json'})
    end

    describe('#initialize bad input') do
        it { expect { described_class.new(client_id: client_id, client_secret: client_secret) }.to raise_error(StandardError,"nil token, exiting!") }
    end 
end
end 
  