# ProZ

[![Gem Version](https://badge.fury.io/rb/proz.svg)](http://badge.fury.io/rb/proz) [![License](https://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat)](https://github.com/diasks2/proz/blob/master/LICENSE.txt)

ProZ is a Ruby wrapper for the [ProZ.com API](http://www.proz.com/api-docs). The ProZ.com 2.0 API is a REST-like API for interacting with ProZ.com services.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'proz'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install proz

## Usage

```ruby
uuid = '893e4488-58a1-4713-992c-c6d90aafa3cb'
Proz::Client.new(key: 'yourAPIkey').freelancer(uuid)['site_name']

# => 'Joe Translator'
```

#### OAuth2

To Setup Your App with ProZ OAuth2

1) Create an account on [ProZ.com](https://www.proz.com)

2) Register an [API client app](https://www.proz.com/oauth/client-apps)

You will be assigned a `client_id` and `client_secret`. You will need to choose a `redirect_uri`. For example, you could choose something like:  
`redirect_uri: https://www.yourdomain.com/proz`  
or  
`redirect_uri: https://www.yourdomain.com`  

3) Create a route in your project for the above `redirect_uri` if that route does not already exist.
If you are building a Rails app, an example might be:

*config/routes.rb*  

```ruby
match '/proz', to: 'static_pages#proz', via: :get
```

4) Create a link within your app 
*controller*
```ruby
proz = Proz::OAuth2.new(client_id: 'yourClientID', client_secret: 'yourClientSecret')
@oauth_link = proz.link
```

*view*
```ruby
<%= link_to "Link your ProZ.com Account", @oauth_link %>
```

5) Exchange authorization code for tokens
```ruby
token = proz.exchange(params[:code])
```

6) Save the token
```ruby
current_user.update_columns(proz_oauth_token: token)
```

7) Retrieve the user's profile info
```ruby
proz.profile(token)

# => {
#      "meta": null, 
#      "data": {
#        "skills": {
#          "specific_disciplines": [], 
#          "language_pairs": [], 
#          "general_disciplines": [
#            {
#              "disc_gen_name": "Tech/Engineering", 
#              "disc_gen_id": 1
#            }, 
#            {
#              "disc_gen_name": "Art/Literary", 
#              "disc_gen_id": 2
#            }, 
#            {
#              "disc_gen_name": "Medical", 
#              "disc_gen_id": 3
#            }, 
#            {
#              "disc_gen_name": "Law/Patents", 
#              "disc_gen_id": 4
#            }, 
#            {
#              "disc_gen_name": "Science", 
#              "disc_gen_id": 5
#            }, 
#            {
#              "disc_gen_name": "Bus/Financial", 
#              "disc_gen_id": 6
#            }, 
#            {
#              "disc_gen_name": "Marketing", 
#              "disc_gen_id": 7
#            }, 
#            {
#              "disc_gen_name": "Other", 
#              "disc_gen_id": 8
#            }, 
#            {
#              "disc_gen_name": "Social Sciences", 
#              "disc_gen_id": 9
#            }
#          ]
#        }, 
#        "site_name": "Kevin Dias", 
#        "uuid": "7bbfdd74-a2a4-484f-8dbc-215a67026ce1", 
#        "profile_url": "http://www.proz.com/profile/1979687", 
#        "contact_info": {
#          "first_name": "Kevin", 
#          "last_name": "Dias", 
#          "middle_name": null
#        }
#      }, 
#      "success": 1
#    }
```

## Contributing

1. Fork it ( https://github.com/diasks2/proz/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

The MIT License (MIT)

Copyright (c) 2015 Kevin S. Dias

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.