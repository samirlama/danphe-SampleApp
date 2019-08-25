FactoryBot.define do
  

  
    factory :user do
      name { "Josephs" }
    # email { "joe@gmail.com" }
      password { "blahblah" }
      password_confirmation { "blahblah" }
      activated { true } 
    end
    factory :invalid_user, class: User do 
      name { "Josephs" }
      # email { "joe@gmail.com" }
        password { "blahblah" }
        password_confirmation { "blahblah" }
        activated { true } 
    end


end