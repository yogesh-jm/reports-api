FactoryBot.define do
    factory :report do
      title { Faker::Lorem.sentence }
      description { Faker::Lorem.paragraph }
      reporter { Faker::Name.name }
    end
  end
