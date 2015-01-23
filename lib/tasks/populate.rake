namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'faker'

    Rake::Task['db:reset'].invoke

    count = 5
    start = count + 1

    count.times do |n|
      funder = Funder.create(
        name: Faker::Company.name,
        contact_number: Faker::PhoneNumber.phone_number,
        website: Faker::Internet.domain_name,
        street_address: Faker::Address.street_address,
        city: Faker::Address.city,
        region: Faker::Address.street_name,
        postal_code: Faker::Address.postcode,
        country: Faker::Address.country,
        charity_number: Faker::Number.number(8),
        company_number: Faker::Number.number(10),
        founded_on: Faker::Date.between(10.years.ago, 5.years.ago),
        registered_on: Faker::Date.between(5.years.ago, Time.now)
      )
      user = User.create(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        job_role: Faker::Name.title,
        user_email: "funder#{n+1}@example.com",
        password: '123123',
        role: 'Funder'
      )
      user.organisation = Funder.find(n+1)
      user.save
    end

    25.times do |n|
      organisation = Recipient.create(
      name: Faker::Company.name,
      contact_number: Faker::PhoneNumber.phone_number,
      website: Faker::Internet.domain_name,
      street_address: Faker::Address.street_address,
      city: Faker::Address.city,
      region: Faker::Address.street_name,
      postal_code: Faker::Address.postcode,
      country: Faker::Address.country,
      charity_number: Faker::Number.number(8),
      company_number: Faker::Number.number(10),
      founded_on: Faker::Date.between(10.years.ago, 5.years.ago),
      registered_on: Faker::Date.between(5.years.ago, Time.now)
      )
      user = User.create(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      job_role: Faker::Name.title,
      user_email: "org#{n+1}@example.com",
      password: '123123',
      )
      user.organisation = Recipient.find(n+1+count)
      user.save

      profile = Profile.create(
        gender: 'All genders',
        currency: 'GBP',
        goods_services: 'Goods',
        who_pays: Faker::Lorem.word,
        who_buys: Faker::Lorem.word,
        year: '2014',
        min_age: rand(0..25),
        max_age: rand(10..120),
        income: Faker::Number.number(5),
        expenditure: Faker::Number.number(5),
        volunteer_count: rand(0..100),
        staff_count: rand(0..50),
        job_role_count: rand(0..25),
        department_count: rand(0..25),
        goods_count: rand(0..25),
        units_count: rand(0..5000),
        services_count: rand(0..25),
        beneficiaries_count: rand(0..5000)
      )
      profile.organisation = Recipient.find(n+1+count)
      profile.save
    end

    10.times do |n|
      grant = Grant.create(
        funding_stream: 'Main',
        grant_type: 'Unrestricted',
        attention_how: 'Headhunting',
        amount_awarded: Faker::Number.number(5),
        amount_applied: Faker::Number.number(5),
        installments: Faker::Number.digit,
        approved_on: Faker::Date.between(10.years.ago, Time.now),
        start_on: Faker::Date.between(10.years.ago, Time.now),
        end_on: Faker::Date.between(10.years.ago, Time.now),
        attention_on: Faker::Date.between(10.years.ago, Time.now),
        applied_on: Faker::Date.between(10.years.ago, Time.now)
      )
      grant.funder = Funder.find(1)
      grant.recipient = Recipient.find(rand(start..25))
      grant.save
    end

    10.times do |n|
      grant = Grant.create(
      funding_stream: 'Main',
      grant_type: 'Unrestricted',
      attention_how: 'Headhunting',
      amount_awarded: Faker::Number.number(5),
      amount_applied: Faker::Number.number(5),
      installments: Faker::Number.digit,
      approved_on: Faker::Date.between(10.years.ago, Time.now),
      start_on: Faker::Date.between(10.years.ago, Time.now),
      end_on: Faker::Date.between(10.years.ago, Time.now),
      attention_on: Faker::Date.between(10.years.ago, Time.now),
      applied_on: Faker::Date.between(10.years.ago, Time.now)
      )
      grant.funder = Funder.find(2)
      grant.recipient = Recipient.find(rand(start..25))
      grant.save
    end

  end
end