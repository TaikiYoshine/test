# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #indexアクション' do
    subject { get :index }
    let!(:user0) { create(:user) }
    let!(:user1) { create(:testuser1) }
    let!(:user2) { create(:testuser2) }
    context '正常' do
      it '正しいレスポンスを返すこと' do
        subject
        expect(response).to be_successful
      end
      it 'has a 200 status code' do
        is_expected.to have_http_status(200)
      end
      it '条件に一致したレコードのみ検索' do
        huser1 = {:id => 106, :name => 'POYO', :email => 'yasao@gmail.com', :birth => '2019/9/11', :sex => '男性', :hobby => '缶蹴り', :job => 'ノージョブ' }
        get :index, params: { user: huser1 }
        users = assigns[:users]
        expect(users[0]).to eq user1
      end
    end
  end

  describe 'GET #newアクション' do
    subject { get :new, params: {}, session: {} }
    context '正常' do
      it 'リクエストは200 OKとなること' do
        is_expected.to have_http_status(200)
      end
      it '@userに新しいユーザーを割り当てること' do
        subject
        expect(assigns(:user)).to be_a_new(User)
      end
    end
  end

  describe 'POST ＃createアクション' do
    subject { post :create, params: { user: attributes_for(:user) }, session: {} }
    context '有効なパラメーターの場合' do
      it '新しいユーザをsave' do
        expect do
          subject
        end.to change(User, :count).by(1)
      end
      it '登録されたユーザーの詳細画面へリダイレクトされる' do
        subject
        expect(response).to redirect_to(User.last)
      end
    end
    context '無効なパラメータの場合' do
      it '名前が無ければnew画面をrenderする' do
        post :create, params: { user: attributes_for(:user, name: nil) }
        expect(response).to render_template(:new)
      end
      it 'メールアドレスが無ければnew画面をrenderする' do
        post :create, params: { user: attributes_for(:user, email: nil) }
        expect(response).to render_template(:new)
      end
      it '生年月日が無ければnew画面をrenderする' do
        post :create, params: { user: attributes_for(:user, birth: nil) }
        expect(response).to render_template(:new)
      end
      it '性別が無ければnew画面をrenderする' do
        post :create, params: { user: attributes_for(:user, sex: nil) }
        expect(response).to render_template(:new)
      end
      it '趣味が無ければnew画面をrenderする' do
        post :create, params: { user: attributes_for(:user, hobby: nil) }
        expect(response).to render_template(:new)
      end
      it '職業が無ければnew画面をrenderする' do
        post :create, params: { user: attributes_for(:user, job: nil) }
        expect(response).to render_template(:new)
      end
      it 'メールアドレスが型通りでなければnew画面をrenderする' do
        post :create, params: { user: attributes_for(:user, email: 'xxxxx') }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET ＃editアクション' do
    subject { get :edit }
    context '正常' do
      let(:user) { create(:user) }
      it 'editのテンプレートをrenderする' do
        user_params = attributes_for(:user)
        get :edit, params: { id: user.id, user: user_params }
        expect(response).to  render_template(:edit)
      end
    end
  end

  describe 'PATCH #updateアクション' do
    subject { patch :update }
    context '正常' do
      let(:user) { create(:user) }
      it '各ユーザーの詳細ページへリダイレクトする' do
        user_params = attributes_for(:user, name: 'new name')
        patch :update, params: { id: user.id, user: user_params }
        expect(response).to redirect_to "/users/#{user.id}"
      end
      it 'ユーザー情報を更新できる' do
        user_params = attributes_for(:user, name: 'new name')
        patch :update, params: { id: user.id, user: user_params }
        expect(user.reload.name).to eq 'new name'
      end
    end
    context '異常' do
      let(:user) { create(:user) }
      it 'ユーザー情報を更新できない(入力値が空)' do
        user_params = attributes_for(:user, name: '')
        patch :update, params: { id: user.id, user: user_params }
        expect(user.reload.name).to eq 'old name'
      end
    end
  end

  describe 'GET #showアクション' do
    let(:user) { create(:user) }
    subject { get :show, params: { id: user.id } }
    context '正常' do
      it 'レスポンスは200' do
        is_expected.to have_http_status(200)
      end
    end
  end

  describe 'DELETE #destroyアクション' do
    let!(:user) { create(:user) }
    subject { delete :destroy, user: @user }
    context '正常' do
      it 'ユーザーを削除できる' do
        expect do
          delete :destroy, params: { id: user.id }, session: {}
        end.to change(User, :count).by(-1)
      end
    end
  end
end
