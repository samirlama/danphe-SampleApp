FactoryBot.define do
    
  factory :user do
      name { "Josephs" }
      sequence(:email) { |n| "joe#{n+100}@gmail.com" }
      trait :invalid_email do
        email { 12312312 }
      end
      password { "blahblah" }
      password_confirmation { "blahblah" }
      trait :user_inactivated do
        activated { false }
      end
      activated { true }
      reset_token { self.new_token }
      reset_digest { self.digest(reset_token) }
      reset_sent_at { Time.now }
      trait :user_admin do
        admin { true }
      end
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