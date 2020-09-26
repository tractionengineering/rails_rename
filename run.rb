# import some Rails magic
class String
  def underscore
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end

  def titelize
    self.underscore.split('_').map(&:capitalize).join(' ')
  end

  def dasherize
    self.underscore.split('_').join('-')
  end
end

# caasing: - `:to_s` for default (CamelCase)
#          - `:underscore`
#          - `:titelize`
#          - `:dasherize`
def rename_in_file(path, casing: :to_s)
  file = File.open(path).read
  new_name = @app_name.send(casing)
  old_name = SAMPLE_APP_NAME.send(casing)
  file.gsub!(old_name, new_name)
  File.open(path, 'w') { |f| f.write(file) }
end

DEFAULT_APP_GIT_URL = 'https://github.com/tractionengineering/traction-scaffold.git'.freeze
SAMPLE_APP_NAME = 'TractionScaffold'.freeze
DEVELOPMENT_KEY = '6fb95877a3fab8dfa405d19897e4bf51'.freeze

puts 'Enter name of the app'
@app_name = ARGV[0] || Kernel.gets.chomp

puts 'Enter name of the git repository'
repo_name = ARGV[1] || Kernel.gets.chomp

system("mkdir #{repo_name}")

# checkout default repo, re-initialize git
puts "cloning #{DEFAULT_APP_GIT_URL} to #{repo_name}/"
system("git clone #{DEFAULT_APP_GIT_URL} #{repo_name}")

puts 'initializing new repository'
system("rm -rf #{repo_name}/.git")
system("git init #{repo_name}")

puts 'renaming config/application.rb'
rename_in_file(File.join(__dir__, repo_name, 'config/application.rb'))
puts 'renaming package.json'
rename_in_file(File.join(__dir__, repo_name, 'package.json'), casing: :underscore)
puts 'renaming config/database.yml'
rename_in_file(File.join(__dir__, repo_name, 'config/database.yml'), casing: :underscore)
puts 'renaming app/views/vue/index.html.erb'
rename_in_file(File.join(__dir__, repo_name, 'app/views/vue/index.html.erb'), casing: :titelize)
rename_in_file(File.join(__dir__, repo_name, 'app/views/vue/index.html.erb'), casing: :dasherize)
puts 'renaming app/vue/utils/environment.ts'
rename_in_file(File.join(__dir__, repo_name, 'app/vue/utils/environment.ts'), casing: :dasherize)

puts 'adding master.key'
system("touch #{File.join(__dir__, repo_name, 'config/master.key')}")
File.open(File.join(__dir__, repo_name, 'config/master.key'), 'w') { |f| f.write(DEVELOPMENT_KEY) }

puts 'removing this script'
File.delete($PROGRAM_NAME)
puts 'DONE'

puts "Hints: cd into #{repo_name} and run the following commands:"
puts '- bundle install'
puts '- bundle exec rails db:create db:migrate'
puts '- yarn'
