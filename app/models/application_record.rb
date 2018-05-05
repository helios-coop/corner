# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.load_data(name)
    YAML.safe_load(File.read(Rails.root.join("config/data/#{name}.yml"))).freeze
  end
end
