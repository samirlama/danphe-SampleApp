FactoryBot.define do
    
  factory :user do
      name { "Josephs" }
      sequence(:email) { |n| "joe#{n+100}@gmail.com" }
      password { "blahblah" }
      password_confirmation { "blahblah" }
      activated { true } 
      reset_token { self.new_token }
      reset_digest { self.digest(reset_token) }
      reset_sent_at { Time.now }
    end

    factory :user_admin, class: User do
      name { "Josephs" }
      sequence(:email) {|n| "joe#{n+5}@gmail.com" }
      password { "blahblah" }
      password_confirmation { "blahblah" }
      admin { true }
      activated { true }
    end

    factory :user2, class: User do 
      name { "Josephs" }
      trait :invalid_email do
        email { 12312312 }
      end
      trait :valid_email do
        email { "samirl@gmail.com" }
      end
        password { "blahblah" }
        password_confirmation { "blahblah" }
        activated { true }
    end

    factory :micropost do
      trait :valid_content do
        content { "sadashdfaysugdyasgduagsudiagsudgasd"}
      end
      trait :invalid_content do
        content { }
      end
      picture { "abcasd1.jpg" }
    end
end