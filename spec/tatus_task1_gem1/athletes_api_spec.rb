# # frozen_string_literal: true
# require 'simplecov'
# require('spec_helper')
# require('./lib/tatus_task1_gem1')

# SimpleCov.start


# RSpec.describe(::TatusTask1Gem1::TokenAPI) do
#   before do
#     stub_const('TestClass', Class.new { include(::Kitman::Zonein::Apis::Athlete) })
#   end

#   let(:instance) { TestClass.new }
#   let(:argument_file) { 'spec/fixtures/athletes_response.json' }
#   let(:expected_body) { JSON.parse(File.read(argument_file), symbolize_names: true) }

#   describe('#all_athletes') do
#     subject(:all_athletes) { instance.all_athletes[0] }

#     before do
#       allow(instance).to receive(:access_token).and_return('test')
#     end

#     context('when access_token is nil') do
#       it { expect { all_athletes }.to raise_error(StandardError) }
#     end

#     context('when access_token is present') do
#       before { allow(instance).to receive(:post).and_return(expected_body) }

#       it { is_expected.to be_a(::TatusTask1Gem1::TokenAPI) }
#     end
#   end

#   # describe('#athlete_by_email') do
#   #   subject(:athlete) { instance.athlete_by_email('test@kitman.com') }

#   #   before do
#   #     allow(instance).to receive(:access_token).and_return('test')
#   #     allow(instance).to receive(:company_id).and_return('test')
#   #   end

#   #   context('when access_token is nil') do
#   #     it { expect { athlete }.to raise_error(StandardError) }
#   #   end

#   #   context('when access_token is present') do
#   #     before { allow(instance).to receive(:get).and_return(expected_body) }

#   #     it { is_expected.to be_a(::Kitman::Zonein::Model::Athlete) }
#   #   end
#   # end
# end