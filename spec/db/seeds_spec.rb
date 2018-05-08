# frozen_string_literal: true

require "rails_helper"

RSpec.describe "seeds" do
  def load_seeds
    load Rails.root.join("db", "seeds.rb")
  end

  it "loads a whole bunch of categories into the database" do
    expect do
      load_seeds
    end.to change(Category, :count).by(1311)

    expect(Category.exists?(name: "not a category")).to be false
    expect(Category.exists?(name: "Qi Gong")).to be true
  end
end
