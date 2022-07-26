# frozen_string_literal: true
require('spec_helper')
require('./lib/tatus_task1_gem1')


RSpec.describe(::TatusTask1Gem1::AthletesAPI) do
    let(:access_token) { 'real-test-token' }
    let(:athletes_file) { 'spec/fixtures/athletes_response.json' }
    let(:expected_athletes_body) { JSON.parse(File.read(athletes_file),symbolize_names: true) }
  
    describe('#initialize atheletes happy path') do
      subject(:athletes_api) { described_class.new(token: access_token) }

      before do
        stub_request(:get, "https://athletedataservice.azurewebsites.net/summary").
         with(
           headers: {
       	  'Authorization'=>'Bearer real-test-token',
       	  'Content-Type'=>'application/x-www-form-urlencoded',
           }).to_return(status: 200, body: expected_athletes_body, headers: {})
      end

      it('athletes body response') do
        athletes = athletes_api.athletes
        expect(athletes.dig(1,:summary,1,:value)).to eq(98)
        expect(athletes.length()).to eq(3)
      end

      it('inspect athletes') do
        expect(athletes_api.inspect).to eq("#<TatusTask1Gem1::AthletesAPI>")
      end
  end

  describe('#initialize bad response') do
    subject(:athletes_api) { described_class.new(token: access_token) }

  before do
    stub_request(:get, "https://athletedataservice.azurewebsites.net/summary").
    with(
      headers: {
      'Authorization'=>'Bearer real-test-token',
      'Content-Type'=>'application/x-www-form-urlencoded',
      }).to_return(status: 404, body: nil, headers: {})
  end

    it('get 404 response') do
      expect(athletes_api.athletes).to be_empty
    end
  end 

  describe('#initialize with empty token') do
      it { expect { described_class.new(token: "") }.to raise_error(StandardError) }
  end 
end 
