# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FavfoodsController, type: :controller do
  describe 'GET #index' do
    subject { get :index }
    let!(:favfood) { create(:favfood, user: user) }
    let!(:user) { create(:user) }
    let!(:user1) {create(:testuser1)}
    let!(:testfood1) {create(:testfood1, user: user1)}
    context '正常' do
      it '正常なレスポンス(200)' do
        get :index, params: { user_id: 105 }
        expect(response.status).to eq 200
      end
      it 'user.idと表示されているfavfoodのfavfood.user_idが一致する' do
        get :index, params: { user_id: user.id }
        favfoods = assigns[:favfoods]
        expect(favfoods[0].user_id).to eq user.id 
      end
    end
  end

  describe 'GET #new' do
    subject { get :new, params: { user_id: 105 } }
    context '正常' do
      it '正常なレスポンス(200)' do
        subject
        expect(response.status).to eq 200
      end
      it '@favfoodがFavfoodクラスのモデルであること' do
        subject
        expect(assigns(:favfood)).to be_a_new(Favfood)
      end
    end
  end

  describe 'POST #create' do
    subject { post :create, params: { favfood: attributes_for(:favfood), user_id: 105 } }
    let!(:user) { create(:user) }
    context '正常' do
      it '新しいfavfoodがsaveされる' do
        expect{ subject }.to change(Favfood, :count).by(1)
      end
      it '登録されたfavfoodの詳細ページにリダイレクトする' do
        subject
        expect(response).to redirect_to "/users/#{user.id}/favfoods/1"
      end
    end
  end

  describe 'GET #edit' do
    subject { get :edit }
    context '正常' do
      let!(:favfood) { create(:favfood, user: user) }
      let!(:user) { create(:user) }
      it 'editのテンプレートをrenderする' do
        favfood_params = attributes_for(:favfood)
        get :edit, params: { user_id: user.id, id: favfood.id, favfood: favfood_params}
        expect(response).to  render_template(:edit)
      end
    end
  end

  describe 'PATCH #update' do
    context '正常' do
      let!(:favfood) { create(:favfood, user: user) }
      let!(:user) { create(:user) }
      it '各favfoodの詳細ページにリダイレクトする' do
        favfood_params = attributes_for(:favfood, favorite_food: 'new food')
        patch :update, params: { user_id: user.id, id: favfood.id, favfood: favfood_params }
        expect(response).to redirect_to "/users/#{user.id}/favfoods/#{favfood.id}"
      end
      it 'favfoodを更新できる' do
        favfood_params = attributes_for(:favfood, favorite_food: 'new food')
        patch :update, params: { user_id: user.id, id: favfood.id, favfood: favfood_params }
        expect(favfood.reload.favorite_food).to eq 'new food'
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
      it 'favfoodを削除できる' do
        expect{ subject }.to change(Favfood, :count).by(-1)
      end
      it '/users/:user_id/favfoodsにリダイレクトする' do
        subject
        expect(response).to redirect_to "/users/#{user.id}/favfoods"
      end
    end
  end
end
