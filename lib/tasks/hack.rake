
namespace :db do
  desc "Fill database with sample data"
    task :populate => :environment do
      Rake::Task['db:reset'].invoke
      make_users
      make_admin
      make_posts
    end
end
   def make_admin
     admin = User.create!(:name =>"Fred Hudson",
                          :email => "remotezen@bell.net",
                          :password =>"password",
                          :password_confirmation=>"password"
                         )
      admin.toggle!(:admin)
   end

    def make_users
         User.create!(
                     :email => "gritty@sympatico.ca",
                     :name => "Fred Hudson",
                     :password => "password",
                     :admin => 1,
                     :handle => "grit"
                    )
                
      99.times do |n|
        name = Faker::Name.name
        email = "example-#{n+1}@railstutorial.org"
        handle = "grit-#{n+1}"
        password = "foobar"
        User.create!(:name =>name,
                     :email => email, 
                     :password =>password,
                     :handle  => handle
        )
      end
    end
    
    def make_posts
      User.all(:limit => 50).each do |user|
        99.times do |n| 
         content = Faker::Lorem.sentence(5)
        user.mposts.create!(:content=>content)
       end
      end
    end
    def make_comments
      users = User.all
      posts = Post.all
      u = users[1..5]
      p = posts[90..99]

    u.product(p).each do |post,user|
        99.times do |n| 
         comment = Faker::Lorem.sentence(5)
         mpost.comments.create!(:comment=>comment, :user_id=>user.id)
       end
      end
    end

    def make_relationships
      users = User.all
      user = users.first
      following = users[1..50]
      followers =  users[3..40]
      following.each {|followed| user.follow!(followed)}
      followers.each{|follower| follower.follow!(user)}
    end
