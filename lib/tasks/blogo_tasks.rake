# desc "Explaining what the task does"
# task :blogo do
#   # Task goes here
# end


namespace :blogo do
  namespace :uninstall do

    desc 'Uninstall blogo migrations'
    task "migrations" do
      Dir["#{Rails.application.root}/db/migrate/*blogo.rb"].each do |file|
        puts "remove #{file}"
        File.delete(file)
      end
    end

  end
end
