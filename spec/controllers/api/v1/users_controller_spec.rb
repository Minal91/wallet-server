require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
    let(:user) { create(:user) }
    let(:valid_attributes) { attributes_for(:user) }
    
    before do
        sign_in user
    end
    
    describe 'GET #show' do
        it 'returns a success response' do
        get :show
        expect(response).to be_successful
        end
    
        it 'assigns @user' do
        get :show
        expect(assigns(:user)).to eq(user)
        end
    end
    
    describe 'PUT #update' do
        context 'with valid parameters' do
        it 'updates the user' do
            put :update, params: { id: user.id, user: valid_attributes }
            user.reload
            expect(user.name).to eq(valid_attributes[:name])
        end
    
        it 'returns a success response' do
            put :update, params: { id: user.id, user: valid_attributes }
            expect(response).to have_http_status(:ok)
        end
        end
    
        context 'with invalid parameters' do
        it 'returns an unprocessable entity response' do
            put :update, params: { id: user.id, user: { name: nil } }
            expect(response).to have_http_status(:unprocessable_entity)
        end
    
        it 'does not update the user' do
            put :update, params: { id: user.id, user: { name: nil } }
            user.reload
            expect(user.name).not_to be_nil
        end
        end
    end
    
    describe 'GET #balance' do
        it 'returns a success response' do
        get :balance
        expect(response).to be_success
end