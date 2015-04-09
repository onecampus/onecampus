### Rails scaffold for miao.

```ruby
rails g model User last_name first_name nick_name uid salt pass avatar email age:integer university address_current birthday:datetime mobile gender access_token expiration_time:datetime last_login_ip register_status last_sign_in_at:datetime language register_type personalized_signature:text country province city region postcode tel

rails g model Addr user_id:integer longitude latitude

rails g model Twitter user_id:integer content:text source url anonymous
```