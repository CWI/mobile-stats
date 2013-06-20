# mobile-stats

App used for live mobile stats generation and presentation

[![Build Status](https://travis-ci.org/CWI/mobile-stats.png?branch=master)](https://travis-ci.org/CWI/mobile-stats)

[![Code Climate](https://codeclimate.com/github/CWI/mobile-stats.png)](https://codeclimate.com/github/CWI/mobile-stats)

# setup

1. After [forking](https://github.com/CWI/mobile-stats/fork), make sure to install `ruby-1.9.3-p429`:
  
  `rvm install ruby-1.9.3-p429`

2. Set RVM Ruby version to 1.9.3:
  
  `rvm use ruby-1.9.3-p429`

3. Install all gems and dependencies:
  
  `bundle install`

4. Prepare database:

  `rake db:migrate`

5. Run `localhost:3000` server:

  `rails s`

6. Happy coding :)
