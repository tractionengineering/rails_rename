DEFAULT_APP_GIT_URL = 'git@github.com:tractionengineering/rails_rename.git'.freeze

puts 'Enter name of the app'
app_name = ARGV[0] || Kernel.gets.chomp

puts 'Enter name of the git repository, hit enter to use the app name'
repo_name = ARGV[1] || Kernel.gets.chomp || app_name

system("mkdir #{repo_name}")

# checkout default repo, re-initialize git
puts "cloning #{DEFAULT_APP_GIT_URL} to #{repo_name}"
system("git clone #{DEFAULT_APP_GIT_URL} #{repo_name}")

puts 'initializing new repository'
system("rm -rf #{repo_name}/.git")
system("git init #{repo_name}")

puts "renaming the app to '#{app_name}'"
# todo

# OR execute the script via CURL instead of keeping a local copy
puts 'removing this script'
system('cd ../')
File.delete($PROGRAM_NAME)
