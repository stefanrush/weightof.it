weightof.it
===========

Compare JavaScript libraries by weight

Setup
-----

Clone project with:

    git clone git@github.com:stefanrush/weightof.it

Enter project folder with:

    cd weightof.it

Create `application.yml` configuration file with:

    cp config/application.example.yml config/application.yml

Add personal configuration settings to `application.yml`.

Install dependencies with:

    bundle install

Setup database with:

    bundle exec rake db:create db:migrate

Seed database with:

    bundle exec rake db:seed

Testing
-------

Switch Capybara driver to Selenium if PhantomJS isn't installed for Poltergeist by updating `spec/support/capybara.rb` to include:

    Capybara.javascript_driver = :selenium

Run test suite with:

    bundle exec rspec

Run guard with:

    bundle exec guard
