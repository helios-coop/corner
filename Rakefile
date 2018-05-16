# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake, for example
# lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks

namespace :db do
  break if Rails.env.production?

  desc "add demo data to the database"
  task populate: :environment do
    load "./db/mock_data.rb"
  end

  Rake::Task["db:reset"].enhance do
    Rake::Task["db:populate"].invoke
  end
end
