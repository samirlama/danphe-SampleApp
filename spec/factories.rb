FactoryBot.define do


    factory :user do
      name { "Josephs" }
      email { "joe@gmail.com" }
      password { "blahblah" }
      password_confirmation { "blahblah" }
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

    factory :micropost do
      content { "sadashdfaysugdyasgduagsudiagsudgasd"}
      picture { "abcasd1.jpg" }
    end

    factory :invalid_micropost, class: Micropost do
      content {  }
      picture { "asdasd.jpg" }
    end

    
end