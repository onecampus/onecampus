== README

nodoc

#### miao question

* 玩法
* 评论模块
* 群聊模块

#### Check code

```ruby
brakeman
bundle exec rails_best_practices .
rubocop -R
```

#### deploy

```ruby
rails s Puma
gem install foreman
```

#### docker-compose

1. [Rails Development environment for OS X using Docker](http://allenan.com/docker-rails-dev-environment-for-osx/)

#### Thin

```ruby
bundle exec thin start -C config/thin/development.yml
bundle exec thin start -C config/thin/production.yml

# stop thin
bundle exec thin stop -C config/thin/development.yml
cat tmp/pids/thin.3001.pid
cat tmp/pids/thin.3002.pid
cat tmp/pids/thin.3003.pid
kill -9 $(cat tmp/pids/thin.3003.pid)


upstream thin {
     server 127.0.0.1:3000;
     server 127.0.0.1:3001;
     server 127.0.0.1:3002;
}

server {
    listen 80;
    server_name acemoney.in;

    root /home/josh/current/public;

    location / {
      proxy_set_header X-Real-IP $remote_addr;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      proxy_set_header Host $http_host;
      proxy_redirect false;

      if (-f $request_filename/index.html) {
        rewrite (.*) $1/index.html break;
      }
      if (-f $request_filename.html) {
        rewrite (.*) $1.html break;
      }
      if (!-f $request_filename) {
        proxy_pass http://thin;
        break;
      }
    }

    error_page 500 502 503 504 /50x.html;
    location = /50x.html {
      root html;
    }
}

# god
https://raw.githubusercontent.com/macournoyer/thin/master/example/thin.god
```