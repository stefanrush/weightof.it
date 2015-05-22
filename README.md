weightof.it
===========

Compare the weight (file size) of different JavaScript libraries

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

Reset database with:

    bundle exec rake db:migrate:reset

Testing
-------

Run test suite with:

    bundle exec rspec

Run guard with:

    bundle exec guard
