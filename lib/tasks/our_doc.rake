require File.expand_path('../our_doc', __FILE__)

namespace :doc do

  desc 'Write documentation for about_doc.html.erb'
  task :about do
    about_comments = OurDoc.get_comments(:about)
    OurDoc.write_comments(about_comments)
  end

  desc 'Write documentation for user_doc.html.erb'
  task :user do
    user_comments = OurDoc.get_comments(:user)
    OurDoc.write_comments(user_comments)
  end

  desc 'Write documentation for developer_doc.html.erb'
  task :developer do
    developer_comments = OurDoc.get_comments(:developer)
    OurDoc.write_comments(developer_comments)
  end

  desc 'Documentation the entire application'
  task :all => [:about, :user, :developer] do
  end

end

