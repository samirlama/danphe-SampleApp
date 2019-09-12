FactoryBot.define do
    
  factory :user do
      name { "Josephs" }
      email { "joe@gmail.com" }
      password { "blahblah" }
      password_confirmation { "blahblah" }
      activated { true } 
      reset_token { self.new_token }
      reset_digest { self.digest(reset_token) }
      reset_sent_at { Time.now }
    end

    factory :user_admin, class: User do
      name { "Josephs" }
      email { "joe2@gmail.com" }
      password { "blahblah" }
      password_confirmation { "blahblah" }
      admin { true }
      activated { true }
    end

    factory :user_admin1, class: User do
      name { "Josephs" }
      email { "joe3@gmail.com" }
      password { "blahblah" }
      password_confirmation { "blahblah" }
      admin { true }
      activated { true }
    end

    factory :user1, class: User do
      name { "Josephs" }
      email { "joe1@gmail.com" }
      password { "blahblah" }
      password_confirmation { "blahblah" }
    end
    
    factory :user2, class: User do
      name { "Josephs" }
      email { "joe2@gmail.com" }
      password { "blahblah" }
      password_confirmation { "blahblah" }
      activated { true } 
    end

    factory :invalid_user, class: User do 
      name { "Josephs" }
       email { 12312312 }
        password { "blahblah" }
        password_confirmation { "blahblah" }
        activated { true }
    end

    factory :valid_user, class: User do
      name { "Josephs" }
      email { "samirl@gmail.com" }
      password { "blahblah" }
      password_confirmation { "blahblah" }
      activated { true }
    end

    factory :micropost do
      content { "sadashdfaysugdyasgduagsudiagsudgasd"}
      picture { "abcasd1.jpg" }
    end

    factory :invalid_micropost, class: Micropost do
      content {  }
      picture { "asdasd.jpg" }
    end    
end