# README

![Wall-E](wall-e.jpg?raw=true "Wall-E")

This is Wall-E. <br>Wall-E is an api service for fetching transaction history form [Etherscan API](https://etherscan.io/myapikey).

<br>Currently available on : <br>https://secure-dawn-87605.herokuapp.com

## Routes

```ruby
                     Prefix Verb   URI Pattern                                       Controller#Action
api_v1_screens_transactions GET    /api/v1/screens/transactions(.:format)            api/v1/screens#transactions
 api_v1_wallet_transactions GET    /api/v1/wallets/:wallet_id/transactions(.:format) api/v1/transactions#index
             api_v1_wallets GET    /api/v1/wallets(.:format)                         api/v1/wallets#index
                            POST   /api/v1/wallets(.:format)                         api/v1/wallets#create
              api_v1_wallet GET    /api/v1/wallets/:id(.:format)                     api/v1/wallets#show
                            PATCH  /api/v1/wallets/:id(.:format)                     api/v1/wallets#update
                            PUT    /api/v1/wallets/:id(.:format)                     api/v1/wallets#update
                            DELETE /api/v1/wallets/:id(.:format)                     api/v1/wallets#destroy
```

## Dependencies

* Redis
* Ethersacn API key [here](https://etherscan.io/myapikey)

```
export ETHERSCAN_KEY=<key here>
export REDIS_URL=redis://localhost:6379/0
```

## Build Instructions

You need `ruby` and `bundler` gem to install dependencies.

* setup your DB connection `config/database.yml`
* setup your db
  `bundle exec rake db:setup`
* run the service
  `bundle exec rails s`

## Tests

Using Rspec for tests.
`bundle exec rspec`

<br>Current coverage status
<br>
```
COVERAGE:  85.88% -- 73/85 lines in 9 files
```
<br> ![test coverage](coverage.png?raw=true "test coverage")

