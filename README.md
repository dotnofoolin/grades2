# Grades2

A simple dashboard for displaying my kids grades. This is the second iteration. The first was written in Python, and this one written in Ruby on Rails.

A key component is the [hac_adapter](https://github.com/dotnofoolin/hac_adapter) gem. It provides the data from the schools grade interface.

## Details

* Developed with Ruby 2.4.3 and Rails 5.1.4
* PostgreSQL is the database of choice.
* Assets are managed with webpacker.
* Bulma is the CSS framework for now.
* rufus-scheduler gem is used to run the importer process twice a day. It's configured with `config/initializers/scheduler.rb`

## Development

After checking out the repo, run `bundle install` to install dependencies. Setup the datbase. Then, run `rspec` to run the tests.

## Deployment

See [DEPLOYMENT](DEPLOYMENT.md)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dotnofoolin/grades2.

Any PR's should have 100% test coverage.
