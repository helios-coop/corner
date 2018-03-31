# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ListingsController do
  let(:satoshi) { create(:user, display_name: 'satoshi') }
  let!(:listing) { create(:listing, submitter: satoshi, lat: 37.791139, long: -122.396067) }

  describe 'GET #index' do
    before { get :index }

    it 'renders the index template' do
      expect(response).to render_template :index
    end

    it 'finds all listings in the db' do
      expect(assigns(:listings).count(:all)).to eq 1
    end
  end

  describe 'GET #new' do
    before do
      login(satoshi)
      get :new
    end

    it 'renders the new template' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before do
      login(satoshi)
      get :edit, params: { id: listing.id }
    end

    it 'renders the index template' do
      expect(response).to render_template :edit
    end

    it 'finds the correct listing' do
      expect(assigns(:listing).name).to eq listing.name
    end
  end

  describe 'PATCH #update' do
    let(:bitcoin)  { create(:currency) }
    let(:litecoin) { create(:currency, name: 'Litecoin') }
    let(:tron)     { create(:currency, name: 'Tron') }

    before do
      login(satoshi)
      listing.currencies = [bitcoin, litecoin]
      patch :update, params: { id: listing.id, currencies: [litecoin.id, tron.id], listing: { name: 'whatevs' } }
    end

    it 'updates currencies' do
      expect(listing.reload.currencies.pluck(:name)).to match_array ['Litecoin', 'Tron']
    end

    it 'soft deletes removed currencies' do
      deleted_currencies_listings = listing.reload.currencies_listings.only_deleted
      expect(deleted_currencies_listings.length).to eq 1
      expect(deleted_currencies_listings.first.currency_id).to eq bitcoin.id
    end
  end

  describe 'POST #create' do
    let(:bitcoin) { create(:currency) }
    let(:currency_params) { [bitcoin.id] }
    let(:google_place_params) { "{\"address_components\":[{\"long_name\":\"135\",\"short_name\":\"135\",\"types\":[\"street_number\"]},{\"long_name\":\"4th Street\",\"short_name\":\"4th St\",\"types\":[\"route\"]},{\"long_name\":\"South of Market\",\"short_name\":\"South of Market\",\"types\":[\"neighborhood\",\"political\"]},{\"long_name\":\"San Francisco\",\"short_name\":\"SF\",\"types\":[\"locality\",\"political\"]},{\"long_name\":\"San Francisco County\",\"short_name\":\"San Francisco County\",\"types\":[\"administrative_area_level_2\",\"political\"]},{\"long_name\":\"California\",\"short_name\":\"CA\",\"types\":[\"administrative_area_level_1\",\"political\"]},{\"long_name\":\"United States\",\"short_name\":\"US\",\"types\":[\"country\",\"political\"]},{\"long_name\":\"94103\",\"short_name\":\"94103\",\"types\":[\"postal_code\"]}],\"adr_address\":\"<span class=\\\"street-address\\\">135 4th St</span>, <span class=\\\"locality\\\">San Francisco</span>, <span class=\\\"region\\\">CA</span> <span class=\\\"postal-code\\\">94103</span>, <span class=\\\"country-name\\\">USA</span>\",\"formatted_address\":\"135 4th St, San Francisco, CA 94103, USA\",\"formatted_phone_number\":\"(415) 369-6000\",\"geometry\":{\"location\":{\"lat\":37.7842717,\"lng\":-122.40315859999998},\"viewport\":{\"south\":37.7829560697085,\"west\":-122.40475683029149,\"north\":37.7856540302915,\"east\":-122.40205886970853}},\"icon\":\"https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png\",\"id\":\"4b2b09fd9203dbad9c8d364296ec5843c698f244\",\"international_phone_number\":\"+1 415-369-6000\",\"name\":\"Metreon\",\"opening_hours\":{\"open_now\":true,\"periods\":[{\"close\":{\"day\":0,\"time\":\"2030\",\"hours\":20,\"minutes\":30,\"nextDate\":1521430200000},\"open\":{\"day\":0,\"time\":\"1030\",\"hours\":10,\"minutes\":30,\"nextDate\":1521394200000}},{\"close\":{\"day\":1,\"time\":\"2030\",\"hours\":20,\"minutes\":30,\"nextDate\":1521516600000},\"open\":{\"day\":1,\"time\":\"1030\",\"hours\":10,\"minutes\":30,\"nextDate\":1521480600000}},{\"close\":{\"day\":2,\"time\":\"2030\",\"hours\":20,\"minutes\":30,\"nextDate\":1521603000000},\"open\":{\"day\":2,\"time\":\"1030\",\"hours\":10,\"minutes\":30,\"nextDate\":1521567000000}},{\"close\":{\"day\":3,\"time\":\"2030\",\"hours\":20,\"minutes\":30,\"nextDate\":1521689400000},\"open\":{\"day\":3,\"time\":\"1030\",\"hours\":10,\"minutes\":30,\"nextDate\":1521653400000}},{\"close\":{\"day\":4,\"time\":\"2030\",\"hours\":20,\"minutes\":30,\"nextDate\":1521775800000},\"open\":{\"day\":4,\"time\":\"1030\",\"hours\":10,\"minutes\":30,\"nextDate\":1521739800000}},{\"close\":{\"day\":5,\"time\":\"2130\",\"hours\":21,\"minutes\":30,\"nextDate\":1521261000000},\"open\":{\"day\":5,\"time\":\"1030\",\"hours\":10,\"minutes\":30,\"nextDate\":1521826200000}},{\"close\":{\"day\":6,\"time\":\"2130\",\"hours\":21,\"minutes\":30,\"nextDate\":1521347400000},\"open\":{\"day\":6,\"time\":\"1030\",\"hours\":10,\"minutes\":30,\"nextDate\":1521307800000}}],\"weekday_text\":[\"Monday: 10:30 AM – 8:30 PM\",\"Tuesday: 10:30 AM – 8:30 PM\",\"Wednesday: 10:30 AM – 8:30 PM\",\"Thursday: 10:30 AM – 8:30 PM\",\"Friday: 10:30 AM – 9:30 PM\",\"Saturday: 10:30 AM – 9:30 PM\",\"Sunday: 10:30 AM – 8:30 PM\"]},\"photos\":[{\"height\":2340,\"html_attributions\":[\"<a href=\\\"https://maps.google.com/maps/contrib/113346107535760992724/photos\\\">Michael Ocampo</a>\"],\"width\":4160},{\"height\":3036,\"html_attributions\":[\"<a href=\\\"https://maps.google.com/maps/contrib/108229825579551254060/photos\\\">Nathan Farey</a>\"],\"width\":4048},{\"height\":3006,\"html_attributions\":[\"<a href=\\\"https://maps.google.com/maps/contrib/110773408367098831359/photos\\\">W B</a>\"],\"width\":5344},{\"height\":3036,\"html_attributions\":[\"<a href=\\\"https://maps.google.com/maps/contrib/101454054922966149236/photos\\\">Juan Abello</a>\"],\"width\":4048},{\"height\":3480,\"html_attributions\":[\"<a href=\\\"https://maps.google.com/maps/contrib/112695256249584453237/photos\\\">gaso lin</a>\"],\"width\":4640},{\"height\":3024,\"html_attributions\":[\"<a href=\\\"https://maps.google.com/maps/contrib/103764383471609156217/photos\\\">Conrad Tran</a>\"],\"width\":4032},{\"height\":3120,\"html_attributions\":[\"<a href=\\\"https://maps.google.com/maps/contrib/116344143380992990925/photos\\\">Stephen Ho</a>\"],\"width\":4160},{\"height\":4032,\"html_attributions\":[\"<a href=\\\"https://maps.google.com/maps/contrib/115493715207290295856/photos\\\">Bengt-Arne Skoog</a>\"],\"width\":3024},{\"height\":480,\"html_attributions\":[\"<a href=\\\"https://maps.google.com/maps/contrib/102184358414478090056/photos\\\">Lynn Friedman</a>\"],\"width\":640},{\"height\":2340,\"html_attributions\":[\"<a href=\\\"https://maps.google.com/maps/contrib/103050022337316612023/photos\\\">Aurice Guyton</a>\"],\"width\":4160}],\"place_id\":\"ChIJ-zhtDYeAhYAREh_HF8J91xQ\",\"rating\":4.2,\"reference\":\"CmRRAAAAbow6H32dsacOhBoust_CRd0GuR0m04MMWCsm2dnwkXdgV5LkWaG84VikwVZ5ZElTmdaqAUqzMJqrWxjMWjPes9w5Ot5s2URoio_afhdOq2m9_S12pXvH1-dkP1ZJlexWEhClCFui4n4OnCI5GTo4K-UlGhTtIVcwYsaOHd2YcOIrRAuz96W0lA\",\"reviews\":[{\"author_name\":\"Ian Larry\",\"author_url\":\"https://www.google.com/maps/contrib/111517521045481434656/reviews\",\"language\":\"en\",\"profile_photo_url\":\"https://lh5.googleusercontent.com/-bhAiZWd8uno/AAAAAAAAAAI/AAAAAAAAAAA/AGi4gfxi-9ZVb9BY0IETjkCluSp3wR8bxg/s128-c0x00000000-cc-rp-mo-ba4/photo.jpg\",\"rating\":5,\"relative_time_description\":\"a week ago\",\"text\":\"Still cool because of it's name but it ain't like it used to be any more and should just use a new name change now. Because of Target is there and that not much of a tourist attraction of a entertainment complex to hang and just shop there. Need new ideas clubs, food spots, events, police patrol, places to shop and hang out and a tech tourism attractions of cool innovation of new future entertainment complex.\",\"time\":1520319298},{\"author_name\":\"Kasey Chang\",\"author_url\":\"https://www.google.com/maps/contrib/101072300058668869255/reviews\",\"language\":\"en\",\"profile_photo_url\":\"https://lh6.googleusercontent.com/-0I2T7azxanA/AAAAAAAAAAI/AAAAAAAACkA/rIKHGQp7Pq0/s128-c0x00000000-cc-rp-mo-ba4/photo.jpg\",\"rating\":4,\"relative_time_description\":\"3 weeks ago\",\"text\":\"Nice clean shopping center with a large food court, in the middle of downtown and walking distance to almost everything. Target has decent selection for its relatively small size, and the cinema has an upgraded screen with he private recliner seats that's really nice. Plenty of places to sit, plenty of choice of food, and nice lawn just outside. It's a nice place to hangout\",\"time\":1519263704},{\"author_name\":\"TRAVIS BREEN\",\"author_url\":\"https://www.google.com/maps/contrib/104114442892016303973/reviews\",\"language\":\"en\",\"profile_photo_url\":\"https://lh5.googleusercontent.com/-PbCYO-I3K2g/AAAAAAAAAAI/AAAAAAAAA3c/Ls0x7FEr7tY/s128-c0x00000000-cc-rp-mo/photo.jpg\",\"rating\":3,\"relative_time_description\":\"2 weeks ago\",\"text\":\"I'm just not a Mall person, but- the Metreon isn't \\\"too much\\\". The Target store still amazes me, it's huge and has good stuff at a decent price. I go there sometimes three times a month. There is a Starbucks and it has plenty of places to sit and people watch, also it's not as crowded as you might expect. I have only been to the movies here once. I'm a big movie person, and even though the theaters have stadium seating, great sound, (Very loud) and special events it's almost phrohibitively expensive. Especially if you are coming with your family. With admission, snacks, parking, and depending on how far you came, it adds up. Oh, there's a 3D theater, but I haven't been. So as far as I'm concernedw.google.com/maps/contrib/107087795957463823927/reviews\",\"language\":\"en\",\"profile_photo_url\":\"https://lh4.googleusercontent.com/-wlmNSmfvVv0/AAAAAAAAAAI/AAAAAAAAAX8/SjIG0XrxWLw/s128-c0x00000000-cc-rp-mo-ba3/photo.jpg\",\"rating\":4,\"relative_time_description\":\"in the last week\",\"text\":\"One of the nicer modern theaters in the city.  Prices are typically pricey, but they do accept Movie Pass which is a plus!  It’s not too far from Powell BART station and ... if you were a depraved human, there is a Target right next door where you could theoretically load up on snacks... but you would be stealing away profits from the movie theater.  Yes it would be wrong to buy a gallon sized bag of M&Ms for $5 when you could buy a tiny box of M&Ms at the movie theater for $15. So wrong!\",\"time\":1520801942},{\"author_name\":\"Sir Christian R. Hadsell\",\"author_url\":\"https://www.google.com/maps/contrib/114715729089112823454/reviews\",\"language\":\"en\",\"profile_photo_url\":\"https://lh6.googleusercontent.com/-5c-_Y2piB1g/AAAAAAAAAAI/AAAAAAAAIME/34o1-QCWERg/s128-c0x00000000-cc-rp-mo/photo.jpg\",\"rating\":4,\"relative_time_description\":\"2 months ago\",\"text\":\"Movie theater is awesome. Seating is hand picked via computer so you don't have to worry about getting in early to snag good seats... I still don't know how I feel about this. That's one part of the excitement of going. Techie carp.\",\"time\":1515434038}],\"scope\":\"GOOGLE\",\"types\":[\"shopping_mall\",\"point_of_interest\",\"establishment\"],\"url\":\"https://maps.google.com/?cid=1501807273327402770\",\"utc_offset\":-420,\"vicinity\":\"135 4th Street, San Francisco\",\"website\":\"http://www.shoppingmetreon.com/\",\"html_attributions\":[]}" }

    let(:valid_params) { { 'google-place': google_place_params } }

    context 'when a user is logged in' do
      before do
        login(satoshi)
        post :create, params: valid_params.merge(currencies: currency_params)
      end

      it 'adds a listing to the database' do
        expect(Listing.count).to eq 2
      end

      it 'sets the submitter correctly' do
        expect(Listing.last.submitter).to eq satoshi
      end

      it 'adds currencies to a listing' do
        expect(assigns(:listing).currencies.pluck(:name)).to eq ['Bitcoin']
      end
    end

    context 'when a user is not logged in' do
      before do
        post :create, params: valid_params
      end

      it 'adds a listing to the database' do
        expect(Listing.count).to eq 1
      end
    end
  end

  describe 'GET #show' do
    before do
      login(satoshi)
      post :show, xhr: true, params: { id: listing.id, format: 'js' }
    end

    it 'finds the correct listing via ajax call' do
      expect(assigns(:listing).name).to eq listing.name
    end
  end
end
