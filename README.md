# Project: Koroibos
Welcome to Koroibos, a JSON API designed to expose endpoints to display data and statistics from the 2016 Summer Olympic Games.

## Intent
This project was completed in 7 days as a requirement for Module 4 at Turing School of Software & Design.

The project was built using Ruby on Rails which implements the following:

* Object oriented programming principles
* Test Driven Development - TDD.
* Advanced database queries and calculations using ActiveRecord.

Production URL: http://koroibos.us-east-2.elasticbeanstalk.com
GitHub Projects Board: https://github.com/jalena-penaligon/koroibos/projects/1

## Tech Stack
* Rails 5.2.3
* Ruby 2.6.3
* PostgreSQL

## Instructions
  ### How to setup:
      git@github.com:jalena-penaligon/koroibos.git
      cd koroibos
      bundle
      rake db:{create,migrate,seed}
      rails s

  ### Available Endpoints:
   #### GET /api/v1/olympians
      Sample Response:
      {
        olympians: [
        {
          name: "Andreea Aanei",
          team: "Romania",
          age: 22,
          sport: "Weightlifting",
          total_medals_won: 0
        },
        {
          name: "Nstor Abad Sanjun",
          team: "Spain",
          age: 23,
          sport: "Gymnastics",
          total_medals_won: 0
      }]
    }

   #### GET /api/v1/olympians?age=youngest
       Sample Response:
       {
        olympian: [
          {
            name: "Ana Iulia Dascl",
            team: "Romania",
            age: 13,
            sport: "Swimming",
            total_medals_won: 0
          }]
        }

  #### GET /api/v1/olympians?age=oldest
      Sample Response:
      {
       olympian: [
         {
           name: "Julie Brougham",
          team: "New Zealand",
          age: 62,
          sport: "Equestrianism",
          total_medals_won: 0
         }]
       }
  #### GET /api/v1/olympian_stats
      Sample Response:
      {
        olympian_stats: {
          total_competing_olympians: 2850,
          average_weight: {
            unit: "kg",
            male_olympians: 77.87,
            female_olympians: 61.41
          },
          average_age: 26.37
        }
      }

  #### GET /api/v1/events
      Sample Response:
      {
        events: [{
          sport: "Weightlifting",
          events: [
            "Weightlifting Men's Light-Heavyweight",
            "Weightlifting Women's Heavyweight",
            "Weightlifting Men's Bantamweight",
            "Weightlifting Women's Featherweight",
            "Weightlifting Women's Light-Heavyweight",
            "Weightlifting Women's Super-Heavyweight",
            "Weightlifting Men's Heavyweight",
            "Weightlifting Men's Middleweight",
            "Weightlifting Men's Middle-Heavyweight",
            "Weightlifting Men's Featherweight",
            "Weightlifting Women's Flyweight",
            "Weightlifting Women's Middleweight",
            "Weightlifting Women's Lightweight",
            "Weightlifting Men's Lightweight",
            "Weightlifting Men's Super-Heavyweight"
          ]
        }]
      }

  #### GET /api/v1/events/:id/medalists
      Sample Response:
        {
          event: "Diving Women's Springboard",
          medalists: [{
            name: "Tania Cagnotto (-Parolin)",
            team: "Italy",
            age: 31,
            medal: "Bronze"
          }]
        }

  ### Running Tests:
    Run tests with rspec:
        $ rspec

  ## Core Contributors:
  Jalena Taylor: https://github.com/jalena-penaligon/

  ## How to Contribute:
  - Fork & clone this repository. Make the desired changes and open a pull request, tagging @jalena-penaligon
