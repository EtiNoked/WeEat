require 'rails_helper'

RSpec.describe RestaurantsController, type: :controller do
  def response_body
    JSON.parse(response.body)
  end

  def create_cuisine
    create(:cuisine, name: 'C1')
  end

  let(:restaurant1) { create(:restaurant, name: 'R1') }
  let(:restaurant2) { create(:restaurant, name: 'R2') }
  let(:restaurant3) { create(:restaurant, name: 'R3') }
  let(:restaurants) { [restaurant1, restaurant2, restaurant3] }
  let(:rest_params) { FactoryBot.attributes_for(:restaurant) }
  let(:rest_no_name) { {cuisine_id: 1, delivery_time: 50} }
  let(:rest_no_cuisine) { {name: 'Rest', delivery_time: 50} }

  describe 'index' do

    context 'returns all the restaurants sorted by name' do
      before do
        create_cuisine
        expect(Restaurant).to receive(:sorted_by_name_asc).and_return(restaurants)
        get :index
      end

      it 'returns an array of 3 restaurants' do
        expect(response_body.length).to eq(3)
      end

      it 'returns status code 200' do
        expect(response.status).to eq(200)
      end
    end

    it 'returns an empty array' do
      get :index
      expect(response_body).to eq([])
    end
  end

  describe 'show' do
    context 'returns a single restaurant' do
      before do
        create_cuisine
        allow(Restaurant).to receive(:find).and_return([restaurant1])
        get :show, params: { id: restaurant1.id }
      end

      it 'returns a single restaurant record' do
        first_rest = response_body.first

        expect(response_body.length).to eq(1)
        expect(first_rest['id']). to eq(restaurant1.id)
        expect(first_rest['name']). to eq(restaurant1.name)
        expect(first_rest['cuisine_id']). to eq(restaurant1.cuisine_id)
        expect(first_rest['ten_bis']). to eq(restaurant1.ten_bis)
        expect(first_rest['address']). to eq(restaurant1.address)
      end

      it 'returns status code 200' do
        expect(response.status).to eq(200)
      end
    end

    context 'no restaurant found' do
      it 'returns 404 when restaurant is not found' do
        get :show, params: { id: 0 }
        expect(response_body['code']).to eq(404)
        expect(response.status).to eq(404)
      end
    end
  end

  describe 'create' do
    context 'with valid arguments' do
      before do
        create_cuisine
      end

      it 'enlarge number of restaurants by 1' do
        expect {
          post :create, params: {restaurant: rest_params}
        }.to change(Restaurant, :count).by(1)
      end
    end

    context 'with invalid arguments - cuisine does not exist' do
      it 'not add a record to restaurant\'s array' do
        expect {
          post :create, params: {restaurant: rest_no_cuisine}
        }.to_not change(Restaurant, :count)
      end

      it 'returns \'Cuisine must exist\' error message' do
        post :create, params: {restaurant: rest_no_cuisine}
        expect(response_body['message']).to eq('Validation failed: Cuisine must exist')
      end

      it 'returns 400 error message' do
        post :create, params: {restaurant: rest_no_cuisine}
        expect(response.status).to eq(400)
        expect(response_body['code']).to eq(400)
      end
    end

    context 'with invalid arguments - name does not exist' do
      before do
        create_cuisine
      end

      it 'not add a record to restaurant\'s array' do
        expect {
          post :create, params: {restaurant: rest_no_name}
        }.to_not change(Restaurant, :count)
      end

      it 'returns \'Name can\'t be blank\' error message' do
        post :create, params: {restaurant: rest_no_name}
        expect(response_body['message']).to eq('Validation failed: Name can\'t be blank')
      end

      it 'returns 400 error message (no name)' do
        post :create, params: {restaurant: rest_no_name}
        expect(response.status).to eq(400)
        expect(response_body['code']).to eq(400)
      end
    end
  end

  describe 'update' do
    before do
      create_cuisine
    end

    it 'update exiting record with valid arguments' do
      post :update, params: {id: restaurant1.id, restaurant: {name: 'bla'}}
      expect(response.status).to eq(202)
    end

    it 'update non-exiting record' do
      post :update, params: {id: 0, restaurant: restaurant2}
      expect(response.status).to eq(404)
    end

    it 'update exiting record with invalid arguments' do
      post :update, params: {id: restaurant1.id, restaurant: {cuisine_id: 3}}
      expect(response.status).to eq(400)
    end
  end

  describe 'destroy' do
    before do
      create_cuisine
    end

    it 'decrease number of records by 1' do
      expect {
        post :delete, params: {id: restaurant1.id}
      }.to change(Restaurant, :count).by(1)
    end

    it 'should return 404 in case the id is not found' do
      post :destroy, params: {id: 0}
      expect(response.status).to eq(404)
      expect(response_body['code']).to eq(404)
    end
  end
end
