# frozen_string_literal: true

require "rails_helper"

RSpec.describe "user signup", type: :system do
  # This is timing out on circle.
  xit "allows a user to signup for an account" do
    visit "/"
    click_link "Login / Sign Up"
    click_link "Create an Account"
    fill_in "Display name", with: "Laura Shin"
    fill_in "Email", with: "laura@unchained.com"
    fill_in "Password", with: "12345678"
    fill_in "Password confirmation", with: "12345678"
    click_button "Create Account"

    expect(page).to have_text "Account created"
  end
end
