# Beehive Giving

## Setup
Prerequisites: [Ruby](https://www.ruby-lang.org), [Bundler](https://bundler.io/), [PostgreSQL](https://www.postgresql.org/).

1. `bundle install`
2. `rails db:setup`
3. Create `.env` file with appropriate configuration:
   ```
   BEEHIVE_DATA_TOKEN=<token>
   BEEHIVE_DATA_FUND_SUMMARY_ENDPOINT=<beehive_data_server>/v1/integrations/fund_summary

   BEEHIVE_INSIGHT_TOKEN=<token> # 'username' in development
   BEEHIVE_INSIGHT_SECRET=<secret> # 'password' in development
   BEEHIVE_INSIGHT_ENDPOINT=<beehive_insight_server>/beneficiaries
   BEEHIVE_INSIGHT_AMOUNTS_ENDPOINT=<beehive_insight_server>/check_amount
   BEEHIVE_INSIGHT_DURATIONS_ENDPOINT=<beehive_insight_server>/check_duration

   STRIPE_SECRET_KEY=<secret_key>
   STRIPE_PUBLISHABLE_KEY=<publishable_key>
   ```

## Importing data
`pg_restore -c -O -d beehive_development <path_to_local_dump_file>`

## Running tests
Use `rspec` to run tests or alternatively use [Guard](https://github.com/guard/guard) to run tests automatically whilst developing with `bundle exec guard`.

Use `rails test` to run deprecated tests.
