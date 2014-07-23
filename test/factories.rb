require 'factory_girl'

FactoryGirl.define do
  factory :travel do
    # name 'John Doe'
    # date_of_birth { 21.years.ago }
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
end
