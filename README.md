# Lunar & Flo API

[![CircleCI](https://circleci.com/gh/samtgarson/lunar-and-flo/tree/master.svg?style=svg&circle-token=773c6e5d936a4587ccff771b00af5c7d855817aa)](https://circleci.com/gh/samtgarson/lunar-and-flo/tree/master)

## Admin

We use [Forest Admin](https://app.forestadmin.com) to manage this application.

## Develop

- **Config**
    - The following environment variables are available:
        - `FORECAST_API_KEY` - our API key for Forecast.io
        - `FOREST_SECRET_KEY` - Enviroment Key for Forest Admin
        - `FOREST_AUTH_KEY` - Auth Key for Forest Admin

- **Database**
    - This app uses _postgres_. Homebrew is the suggested installation method on a Mac.

- **Environment**
    - This app uses _.env_ to load up environment variables in development. Run `cp .env.test .env`
    - `bundle install`
    - `bundle exec rake db:setup`

- **Testing**
    - This app uses Minitest and the [m gem](https://github.com/qrush/m). 
        - `bundle exec rake db:test:prepare`
        - `bundle exec m`
    - Ensure code passes Rubocop. Run `bundle exec rubocop`

- **Deploy**
    - We deploy to Heroku.
    - After passing CI, the Develop branch is deployed automatically to Staging
    - After passing CI, the Master branch is deployed automatically to Production
    - New Pull Requests get Review apps automatically created for them
