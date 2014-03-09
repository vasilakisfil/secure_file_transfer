task :create_test_users => [:environment] do
  desc "Create Users for custom testing"
  (0..5).each do |i|
    User.create({
      username: "username#{i}",
    })
  end
end
