require "bundler/setup"
require "tatus_task1_gem1"


if ARGV.length < 2
    puts "Too few arguments"
    exit
  end
   
  client_id= ARGV[0]
client_secret= ARGV[1]

@client = TatusTask1Gem1::Client.new(client_id: client_id, client_secret: client_secret)
puts JSON.pretty_generate(@client.all_athletes)

@client2 = TatusTask1Gem1::TokenAPI.new(client_id: client_id, client_secret: client_secret)
puts @client2.token
