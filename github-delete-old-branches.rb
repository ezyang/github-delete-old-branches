require 'octokit'
require 'time'
require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: github-delete-old-branches.rb [--dry-run] REPO ACCESS_TOKEN"

  opts.on("-n", "--dry-run", "Print which branches would be deleted") do |v|
    options[:dry_run] = v
  end
end.parse!

client = Octokit::Client.new(:access_token => ARGV[1])
user = client.user
user.login
repo = ARGV[0]

client.branches(repo).each do |b|
    next if b.name == 'master'
    binfo = client.branch(repo, b.name)
    if binfo.commit.commit.committer.date < Time.now - (21*24*60*60)
        if options[:dry_run]
            puts b.name
        else
            puts b.name
            client.delete_branch(repo, b.name) or STDERR.puts "ERROR: Could not delete #{b.name}"
        end
    end
end
