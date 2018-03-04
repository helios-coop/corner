require "rails_helper"

describe ListingsController do

  let!(:listing) { Listing.create(name: "Pizza House", submitter_id: 1) }
  before { subject }

  describe "GET #index" do
    subject { get :index }

    it "renders the index template" do
      expect(subject).to render_template :index
    end

    it "finds all listings in the db" do
      expect(assigns(:listings).count).to eq 1
    end
  end

  describe "GET #new" do
    subject { get :new }

    it "renders the new template" do
      expect(subject).to render_template :new
    end
  end

  describe "GET #edit" do
    subject { get :edit, params: {id: listing.id} }

    it "renders the index template" do
      expect(subject).to render_template :edit
    end

    it "finds the correct listing" do
      expect(assigns(:listing).name).to eq listing.name
    end
  end

  describe "POST #create" do
    subject { get :create, params: {listing: {name: "Satoshi's Pub", submitter_id: 1}} }

    it "adds a listing to the database" do
      expect(Listing.count).to eq 2
    end
  end
end
