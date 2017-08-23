# Devise

### Gemfile
```
# Gemfile
gem 'devise'
```
```
$ bundle install
```

### devise 설치
```
$ rails g devise:install
      create  config/initializers/devise.rb
      create  config/locales/devise.en.yml
```
```ruby
# config/environments/development.rb
Rails.application.configure do

	...
    # devise
	config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
end
```

### 모델생성
```
$ rails g devise user
      invoke  active_record
      create    db/migrate/20170823061905_devise_create_users.rb
      create    app/models/user.rb
      invoke    test_unit
      create      test/models/user_test.rb
      create      test/fixtures/users.yml
      insert    app/models/user.rb
       route  devise_for :users
```
```
$ rails db:migrate
```

### 뷰 생성
```
$ rails g devise:views
      invoke  Devise::Generators::SharedViewsGenerator
      create    app/views/devise/shared
      create    app/views/devise/shared/_links.html.erb
      invoke  form_for
      create    app/views/devise/confirmations
      create    app/views/devise/confirmations/new.html.erb
      create    app/views/devise/passwords
      create    app/views/devise/passwords/edit.html.erb
      create    app/views/devise/passwords/new.html.erb
      create    app/views/devise/registrations
      create    app/views/devise/registrations/edit.html.erb
      create    app/views/devise/registrations/new.html.erb
      create    app/views/devise/sessions
      create    app/views/devise/sessions/new.html.erb
      create    app/views/devise/unlocks
      create    app/views/devise/unlocks/new.html.erb
      invoke  erb
      create    app/views/devise/mailer
      create    app/views/devise/mailer/confirmation_instructions.html.erb
      create    app/views/devise/mailer/email_changed.html.erb
      create    app/views/devise/mailer/password_change.html.erb
      create    app/views/devise/mailer/reset_password_instructions.html.erb
      create    app/views/devise/mailer/unlock_instructions.html.erb
```

또는 gem을 이용해서 간단하게 설정할 수 있다.
```
# Gemfile
gem 'devise-i18n'
```

```ruby
# config/application.rb
require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Devise
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.i18n.default_locale = :ko
  end
end
```

```
$ rails g devise:i18n:locale ko
      create  config/locales/devise.views.ko.yml
```
한국어 버전의 devise view가 생성된다.


# cancancan (권한 부여), rolify (역할, 등급을 부여)
- [cancancan](https://github.com/CanCanCommunity/cancancan)
- [rolify](https://github.com/RolifyCommunity/rolify)

### Gemfile
```
gem 'cancancan'
gem 'rolify'
```
```
$ bundle install
```

```
$ rails generate cancan:ability
      create  app/models/ability.rb
```
```
$ rails generate rolify Role User
      invoke  active_record
      create    app/models/role.rb
      invoke    test_unit
      create      test/models/role_test.rb
      create      test/fixtures/roles.yml
      insert    app/models/role.rb
      create    db/migrate/20170823064501_rolify_create_roles.rb
      insert  app/models/user.rb
      create  config/initializers/rolify.rb
```
```
$ rails db:migrate
```

### 모델 관계 설정
```ruby
class Home < ApplicationRecord
	belongs_to :user
end
```
```ruby
class User < ApplicationRecord
  has_many :posts
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
```
```
$ rails g migration AddUserIdToHomes user_id:integer
```

### 권한부여(Cancancan 사용법)
```ruby
# ability.rb
class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
      user ||= User.new # guest user (not logged in)
      if user.nil?
        can :read, :all
      else
        can [:read,:write], :all
      end
    #
  end
end
```
```ruby
# homes_controller
  def new
    @home = Home.new
    authorize! :write, @home
  end
```
```ruby
# home.rb
	resourcify
```

### rolify사용

```
$ User.first.add_role 'admin'   
$ User.first.has_role? 'admin'
```

```ruby
class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    # user ||= User.new # guest user (not logged in)
      if user.nil?
        can :read, :all
      elsif user.has_role? 'newbi'
        can [:read,:create], :all
        can [:update,:destroy], Home, user_id: user.id
      elsif user.has_role? 'manager'
        can [:read,:create,:update], :all
        can :destroy, Home, user_id: user.id
      elsif user.has_role? 'admin'
        can [:read,:create,:update,:destroy], :all
      end

  end
end
```
```ruby
# homes_controller
load_and_authorize_resource
```
(read,create,update,destroy)에 한해서 자동으로 권한이 어떤 액션에 속하는지 지정이되어있다.