namespace :blogo do
  desc 'Create admin user'
  task :create_admin, [:name, :email, :password] => :environment do |task, args|
    attrs = args.to_hash
    attrs[:password_confirmation] = attrs[:password]
    Blogo::User.create!(attrs)
    puts "Admin #{attrs[:email]} created"
  end
end
