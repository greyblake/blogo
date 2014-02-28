require 'fileutils'

desc "Create nondigest versions of all ckeditor digest assets"
task "assets:precompile" do
  fingerprint = /\-[0-9a-f]{32}\./
  for file in Dir["public/assets/blogo/ckeditor/**/*"]
    next unless file =~ fingerprint
    nondigest = file.sub fingerprint, '.'
    if !File.exist?(nondigest) or File.mtime(file) > File.mtime(nondigest)
      FileUtils.cp file, nondigest, verbose: true
    end
  end
end


namespace :blogo do
  desc 'Create blog user'
  task :create_user, [:name, :email, :password] => :environment do |task, args|
    attrs = args.to_hash
    attrs[:password_confirmation] = attrs[:password]
    Blogo::User.create!(attrs)
    puts "Admin #{attrs[:email]} created"
  end
end

