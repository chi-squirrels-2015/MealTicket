MealTicket
==========

*MealTicket is a Dev Bootcamp Phase 3 final project created by Matthew Gray, Edward Mitchell, Jane Kim, and Andrew Irwin.*

### Purpose

MealTicket is a mobile-first e-commerce platform that uses the Yelp and MapBox API 
to connect empty restaurants with hungry patrons.
This project was the capstone 8-day project meant to showcase the technical abilities 
of the team members after completing a 19-week intensive software developer training program.

### Getting Started

MealTicket is built on Rails 4, using the base gem
dependencies as well as the additional gems below:

##### Production:
* pg
* bootstrap
* bcrypt
* geocoder
* ejs

##### Development, Test:
* rspec-rails

### Additional APIs

MealTicket relied heavily on the use of these APIs:

* Yelp
* Stripe
* Twilio
* Mapbox

### Configuration

The database for all environments is PostgreSQL.  Be sure the most
recent version of Postgres is installed and configured on your machine
before creating, migrating and seeding the database.

The server can be started with ```rails s``` once the database has been
seeded with the provided seed file.

### Testing

The rspec test suite can be run with the command ```bundle exec rspec spec/``` follwed by the test suite you choose to run.
