require "bundler/setup"
require "tatus_task1_gem1"


if ARGV.length < 4
    puts "Too few arguments"
    exit
  end
   
  client_id= ARGV[0]
client_secret= ARGV[1]
grant_type=ARGV[2]
audience=ARGV[3]

@client = TatusTask1Gem1::Client.new(client_id: client_id, client_secret: client_secret, grant_type: grant_type, audience: audience)
puts "result:\n #{@client.print_token}"
