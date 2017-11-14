require 'Octokit'
require 'io/console'

def get_username
  print "=> GitHub Username: "
  gets.chomp
end

def get_password
  print "=> GitHub Password: "
  password = STDIN.noecho(&:gets).chomp
  puts ""
  password
end

def client
  client = Octokit::Client.new(:login => get_username,
                               :password => get_password)
  client.auto_paginate = true
  client
end

client.org_repos("chi-rock-doves-2017").each do | repo |
  if File.exist?(repo.name)
    puts "#{repo.name} has already been cloned"
  else
    puts "Cloning #{repo.name}"
    `git clone #{repo.clone_url}`
    system "mv getAllBranches.sh #{repo.name}/getAllBranches.sh"
    Dir.chdir("#{repo.name}") do
      system "chmod +x getAllBranches.sh"    
      system "sh getAllBranches.sh"
      system 'mv getAllBranches.sh ../getAllBranches.sh'
    end
  end
end
