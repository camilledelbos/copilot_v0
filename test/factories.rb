require 'factory_girl'

FactoryGirl.define do
  
  factory :travel do
  end
  
  factory :user do
    email 'exemple@exemple.com'
    password 'aaaaaaaa'
    # name 'John Doe'
    # date_of_birth { 21.years.ago }
  end
  
  factory :prospect do
    # name 'John Doe'
    # date_of_birth { 21.years.ago }
  end

  factory :stage do
    duration 1
    travel
    # name 'John Doe'
    # date_of_birth { 21.years.ago }

    trait :kingston do
    latitude 44.2311717 
    longitude -76.4859544
    address 'kingston'
    end

    trait :katherine do
    latitude -14.4649669
    longitude 132.2642561
    address 'katherine'
    end

    trait :trinidad do
    latitude 37.1694632
    longitude -104.5005407
    address 'trinidad'      
    end

    trait :vanadzor do
    latitude 40.812778
    longitude 44.488333
    address 'vanadzor'      
    end
  end

  factory :climate do
    
  end

end
