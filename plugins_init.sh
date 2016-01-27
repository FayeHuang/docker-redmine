#/bin/bash

RAILS_ENV=production
export RAILS_ENV

bundle exec rake db:migrate
bundle exec rake tmp:cache:clear
bundle exec rake tmp:sessions:clear 

# labels=false : disable the label download
bundle exec rake redmine:backlogs:install labels=false
bundle exec rake redmine:plugins NAME=redmine_checklists
