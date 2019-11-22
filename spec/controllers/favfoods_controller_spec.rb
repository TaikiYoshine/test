# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FavfoodsController, type: :controller do
  describe 'GET #index' do
    subject { get :index, params: params }
    let!(:favfood) { create(:favfood, user: user) }
    let!(:user) { create(:user) }
    let!(:user1) { create(:testuser1) }
    let!(:testfood1) { create(:testfood1, user: user1) }
    let(:params) {}
    context '正常' do
      let (:params) { { user_id: user.id } }
      it 'user.idと表示されているfavfoodのfavfood.user_idが一致する' do
        is_expected.to have_http_status(200)
        expect(assigns[:favfoods][0].user_id).to eq user.id 
      end
    end
  end

  describe 'GET #new' do
    subject { get :new, params: { user_id: 105 } }
    context '正常' do
      it '@favfoodがFavfoodクラスのモデルであること' do
        is_expected.to have_http_status(200)
        expect(assigns(:favfood)).to be_a_new(Favfood)
      end
    end
  end

  describe 'POST #create' do
    subject { post :create, params: { favfood: attributes_for(:favfood), user_id: 105 } }
    let!(:user) { create(:user) }
    context '正常' do
      it '新しいfavfoodがsave、リダイレクト' do
        expect { subject }.to change(Favfood, :count).by(1)
        expect(response).to redirect_to "/users/#{user.id}/favfoods/1"
      end
    end
  end

  describe 'GET #edit' do
    subject { get :edit, params: params }
    let(:params) {}
    context '正常' do
      let!(:favfood) { create(:favfood, user: user) }
      let!(:user) { create(:user) }
      let(:params) { { user_id: user.id, id: favfood.id, favfood: attributes_for(:favfood) } }
      it 'editのテンプレートをrenderする' do
        is_expected.to have_http_status(200)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'PATCH #update' do
    subject { patch :update, params: params }
    context '正常' do
      let!(:favfood) { create(:favfood, user: user) }
      let!(:user) { create(:user) }
      let(:params) { { user_id: user.id, id: favfood.id, favfood: attributes_for(:favfood, favorite_food: 'new food') } }
      it 'favfoodを更新、リダイレクトする' do
        is_expected.to have_http_status(302)
        expect(favfood.reload.favorite_food).to eq 'new food'
        expect(response).to redirect_to "/users/#{user.id}/favfoods/#{favfood.id}"
      end
    end
  end

  describe 'GET #show' do
    let!(:favfood) { create(:favfood, user: user) }
    let!(:user) { create(:user) }
    subject { get :show, params: { user_id: user.id, id: favfood.id } }
    context '正常' do
      it '正常なレスポンス(200)' do
        is_expected.to have_http_status(200)
      end
    end
  end

  describe 'DELETE #destroy' do
    context '正常' do
      let!(:favfood) { create(:favfood, user: user) }
      let!(:user) { create(:user) }
      subject { delete :destroy, params: { id: favfood.id, user_id: user.id } }
      it 'favfoodを削除、リダイレクト' do
        expect { subject }.to change(Favfood, :count).by(-1)
        expect(response).to redirect_to "/users/#{user.id}/favfoods"
      end
    end
  end
end
