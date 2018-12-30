# README

![Wall-E](wall-e.jpg?raw=true "Wall-E")

This is Wall-E. <br>Wall-E is an api service for fetching transaction history form [Etherscan API](https://etherscan.io/myapikey).

<br>Currently available on : <br>https://secure-dawn-87605.herokuapp.com

## Routes

Postman API reference : https://documenter.getpostman.com/view/6265753/RznBMzh6

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
COVERAGE:  90.59% -- 77/85 lines in 9 files
```
<br> ![test coverage](coverage.png?raw=true "test coverage")


## Samples responses
* /api/v1/screens/transactions
```json
{
	"2018-12-15 00:00:00 +0000": [{
			"type": "received",
			"amount": "0.01",
			"timestamp": "1538658458",
			"date": "2018-12-15T00:00:00.000+00:00",
			"wallet_name": "test wallet"
		},
		{
			"type": "received",
			"amount": "0.000001",
			"timestamp": "1529978973",
			"date": "2018-12-15T00:00:00.000+00:00",
			"wallet_name": "test wallet"
		}
	],
	"2018-12-14 00:00:00 +0000": [{
			"type": "sent",
			"amount": "10600.0",
			"timestamp": "1469624867",
			"date": "2018-12-14T00:00:00.000+00:00",
			"wallet_name": "test wallet"
		},
		{
			"type": "sent",
			"amount": "10000.0",
			"timestamp": "1469624584",
			"date": "2018-12-14T00:00:00.000+00:00",
			"wallet_name": "test wallet"
		}
	]
}
```

* /api/v1/wallets/

```json
[{
	"id": 2,
	"name": "test wallet",
	"address": "0xddbd2b932c763ba5b1b7ae3b362eac3e8d40121a",
	"created_at": "2018-12-30T10:54:54.831Z",
	"updated_at": "2018-12-30T10:54:54.831Z"
}]
```

* /api/v1/wallets/2/transactions
```json
[{
		"blockNumber": "6451971",
		"timeStamp": "1538658458",
		"hash": "0xce1970a7624dcfbbde1f5b2a06a89b53d0a0b65156cbebe07cce6fe1177a659f",
		"nonce": "3",
		"blockHash": "0xf3b3321cdace26923fd00d573ab481b1da0bc66a90bacddfd434248b54e4d47b",
		"transactionIndex": "16",
		"from": "0x75fe0f54c65ca39c23d82eb1bada90e4af99a39e",
		"to": "0xddbd2b932c763ba5b1b7ae3b362eac3e8d40121a",
		"value": "10000000000000000",
		"gas": "21000",
		"gasPrice": "41000000000",
		"isError": "0",
		"txreceipt_status": "1",
		"input": "0x",
		"contractAddress": "",
		"cumulativeGasUsed": "502068",
		"gasUsed": "21000",
		"confirmations": "528181"
	},
	{
		"blockNumber": "5854994",
		"timeStamp": "1529978973",
		"hash": "0x1b5dade100a89bf52b027c27a17d07164a466fd7bc72475682b14da8d4602828",
		"nonce": "5",
		"blockHash": "0x6ab38e5a4f0749c2881e84f6e64e70a56507fe75b07e621a9239e99dc202d196",
		"transactionIndex": "38",
		"from": "0x1ce264616911bfd991042ee1dfd3e6df30b3d948",
		"to": "0xddbd2b932c763ba5b1b7ae3b362eac3e8d40121a",
		"value": "1000000000000",
		"gas": "21000",
		"gasPrice": "1562000000",
		"isError": "0",
		"txreceipt_status": "1",
		"input": "0x",
		"contractAddress": "",
		"cumulativeGasUsed": "3109356",
		"gasUsed": "21000",
		"confirmations": "1125158"
	}
]
```

* /api/v1/wallets/2/transactions?format_response=true
```json
[{
		"type": "received",
		"amount": "0.01",
		"timestamp": "1538658458",
		"date": "2018-12-15T00:00:00.000+00:00",
		"wallet_name": "test wallet"
	},
	{
		"type": "received",
		"amount": "0.000001",
		"timestamp": "1529978973",
		"date": "2018-12-15T00:00:00.000+00:00",
		"wallet_name": "test wallet"
	}
]
```