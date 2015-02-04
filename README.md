# ProZ

[![Gem Version](https://badge.fury.io/rb/proz.svg)](http://badge.fury.io/rb/proz) [![License](https://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat)](https://github.com/diasks2/proz/blob/master/LICENSE.txt)

ProZ is a Ruby wrapper for the [ProZ.com API](http://www.proz.com/api-docs). The ProZ.com 2.0 API is a REST-like API for interacting with ProZ.com services.

## Install

**Ruby**  
*Supports Ruby 2.1.5 and above*  
```
gem install proz
```

**Ruby on Rails**  
Add this line to your application’s Gemfile:  
```ruby 
gem 'proz'
```

## Usage

#### Directory Service API

##### Freelancer

Get a representation of a single freelancer by providing that freelancer's [uuid](http://www.proz.com/api-docs/formats/uuid). The uuid is not provided publicly by ProZ so you have to obtain it either through the Freelancer Match API or the OAuth2 API.

```ruby
freelancer = Proz::Freelancer.new(key: 'yourAPIkey', uuid: '663e4488-58a1-4713-992c-c6d90aafa3cb')

freelancer.site_name
# => 'Smartranslators'
```

**Supported Methods**  
* `uuid`
* `site_name`
* `profile_url`
* `contact_info`
* `skills`

Further details for each method can be found in the [ProZ API Specification](http://www.proz.com/api-docs/types/freelancer).

##### Freelancer Matches

Get freelancers that match a set of criteria. A [language pair](http://www.proz.com/api-docs/formats/language-pair) is required for this query. The language pair code should be in the form of a source language code, an underscore, and a target language code. The language codes are a variation of an earlier version of the ISO 639-2 standard, so please check the [ProZ language code](http://www.proz.com/api-docs/codes/language) list to make sure you have the correct language code.

You can pass any number of [optionial parameters](http://www.proz.com/api-docs/directory/get-freelancer-matches). The default number of freelancers returned is 10.

```ruby
fm = Proz::FreelancerMatches.new(key: 'yourAPIkey', language_pair: 'eng_esl')
fm.freelancer_matches[0]['freelancer']['uuid']
# => '663e4488-58a1-4713-992c-c6d90aafa3cb'

fm = Proz::FreelancerMatches.new(key: 'yourAPIkey', language_pair: 'eng_esl', min_yrs_proz: 10, country_code: 'us')
fm.freelancer_matches[0]['freelancer']['uuid']
# => 'b9eade6d-33ac-4c7d-b6f1-42905375fc0b'
```

#### OAuth2

To Setup Your App with ProZ OAuth2

1. Create an account on [ProZ.com](https://www.proz.com)

2. Register an [API client app](https://www.proz.com/oauth/client-apps)

  You will be assigned a `client_id` and `client_secret`. You will need to choose a `redirect_uri`. For example, you could choose something like: `redirect_uri: https://www.yourdomain.com/proz` or `redirect_uri: https://www.yourdomain.com`  

3. Create a route in your project for the above `redirect_uri` if that route does not already exist.
  If you are building a Rails app, an example might be:

  *config/routes.rb*  

  ```ruby
  match '/proz', to: 'static_pages#proz', via: :get
  ```

4. Create a link within your app  
  *controller*
  ```ruby
  proz = Proz::OAuth.new(client_id: 'yourClientID', client_secret: 'yourClientSecret', redirect_uri: 'yourRedirectURI')
  @oauth_link = proz.link
  ```

  *view*
  ```ruby
  <%= link_to "Link your ProZ.com Account", @oauth_link %>
  ```

5. Exchange authorization code for tokens  
  ```ruby
  token = proz.exchange_code_for_token(params[:code])
  ```

6. Save the token and refresh token  
  ```ruby
  current_user.update_columns(proz_oauth_token: token['access_token'], proz_refresh_token: toekn['refresh_token'])
  ```

7. Retrieve the user's profile info  
  ```ruby
  proz = Proz::Profile.new(token: token)
  proz.uuid
  # => '7bbfdd74-a2a4-484f-8dbc-215a67026ce1'

  proz.site_name
  # => 'Kevin Dias'

  proz.profile_url
  # => 'http://www.proz.com/profile/1979687'
  ```

  **Supported Methods**  
  * `uuid`
  * `site_name`
  * `profile_url`
  * `contact_info`
  * `skills`

Further details for each method can be found in the [ProZ API Specification](http://www.proz.com/api-docs/types/freelancer).

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