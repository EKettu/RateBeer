FactoryBot.define do
    factory :user do
      username { "Pekka" }
      password { "Foobar1" }
      password_confirmation { "Foobar1" }
    end

    factory :user2, class: User do
        username { "Ulla" }
        password { "Kissa1" }
        password_confirmation { "Kissa1" }
      end

    factory :brewery do
        name { "Anonymous" }
        year { 1900 } 
      end
    
      factory :beer do
        name { "anonymous" }
        style { "Lager" } 
        brewery
      end
    
      factory :rating do
        beer
        user
        score {4}
      end
  end