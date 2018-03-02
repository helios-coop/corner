require "rails_helper"

describe LocationsController do

  let!(:location) { Location.create(name: "Pizza House", address: "123 main st") }
  before { subject }

  describe "GET #index" do
    subject { get :index }

    it "renders the index template" do
      expect(subject).to render_template :index
    end

    it "finds all locations in the db" do
      expect(assigns(:locations).count).to eq 1
    end
  end

  describe "GET #new" do
    binding.pry
    subject { get :new }

    it "renders the new template" do
      expect(subject).to render_template :new
    end
  end

  describe "GET #edit" do
    subject { get :edit, params: {id: location.id} }

    it "renders the index template" do
      expect(subject).to render_template :edit
    end

    it "finds the correct location" do
      expect(assigns(:location).name).to eq location.name
    end
  end

  describe "POST #create" do
    subject { get :create, params: {location: {name: "Satoshi's Pub", address: "1000 Broadway"}} }

    it "adds a location to the database" do
      expect(Location.count).to eq 2
    end
  end
end
