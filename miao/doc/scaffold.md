### Rails scaffold for miao.

```ruby
rails g model User last_name first_name nick_name uid salt pass avatar email age:integer university_id:integer address_current birthday:datetime mobile gender access_token expiration_time:datetime last_login_ip register_status last_sign_in_at:datetime language register_type personalized_signature:text country province city region postcode tel

rails g model Addr user_id:integer longitude latitude

rails g model Twitter user_id:integer content:text source url parent_id:integer anonymous:integer longitude latitude status:integer

rails g model Picture user_id:integer twitter_id:integer url status:integer

rails g model ChinaCity area_code:integer area parent_code:integer level:integer

rails g model University university_code:integer name intro:text province_id:integer english_name longitude latitude
rails g model College college_code:integer name intro:text university_code:integer

rails g migration AddCreateByToUsers create_by:integer

rails g migration AddToUserIdToTwitters to_user_id:integer
```