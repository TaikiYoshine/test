# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #indexアクション' do
    subject { get :index, params: params }
    let(:params) {}
    let!(:user0) { create(:user) }
    let!(:user1) { create(:testuser1) }
    let!(:user2) { create(:testuser2) }
    context '値を入力して検索' do
      let(:params) { { user: { id: 106, name: 'POYO', email: 'yasao@gmail.com', birth: '2019/9/11', sex: '男性', hobby: '缶蹴り', job: 'ノージョブ' } } }
      it '条件に一致したレコードのみ表示' do
        is_expected.to have_http_status(200)
        users = assigns[:users]
        expect(users[0]).to eq user1
      end
    end
    context '値を入力せずに検索' do
      let(:params) { { user: { name: nil, email: nil, birth: nil, sex: nil, hobby: nil, job: nil } } }
      it '全レコードを表示' do
        is_expected.to have_http_status(200)
        users = assigns[:users]
        expect(users.count).to eq User.count
      end
    end
  end

  describe 'GET #newアクション' do
    subject { get :new, params: {}, session: {} }
    context '正常' do
      it '@userに新しいユーザーを割り当てること' do
        is_expected.to have_http_status(200)
        expect(assigns(:user)).to be_a_new(User)
      end
    end
  end

  describe 'POST ＃createアクション' do
    subject { post :create, params: params }
    let(:params) {}
    context '有効なパラメーターの場合' do
      let(:params) { { user: attributes_for(:user) } }
      it '新しいユーザをsave、リダイレクト' do
        expect { subject }.to change(User, :count).by(1)
        expect(response.status).to be 302
        expect(response).to redirect_to(User.last)
      end
    end
    context '無効なパラメーター' do
      context '名前がnil' do
        let(:params) { { user: attributes_for(:user, name: nil) } }
        it 'new画面をrender' do
          subject
          expect(response).to render_template(:new)
        end
      end
      context 'メールアドレスがnil' do
        let(:params) { { user: attributes_for(:user, email: nil) } }
        it 'new画面をrender' do
          subject
          expect(response).to render_template(:new)
        end
      end
      context '生年月日がnil' do
        let(:params) { { user: attributes_for(:user, birth: nil) } }
        it 'new画面をrender' do
          subject
          expect(response).to render_template(:new)
        end
      end
      context '性別がnil' do
        let(:params) { { user: attributes_for(:user, sex: nil) } }
        it 'new画面をrender' do
          subject
          expect(response).to render_template(:new)
        end
      end
      context '趣味がnil' do
        let(:params) { { user: attributes_for(:user, hobby: nil) } }
        it 'new画面をrender' do
          subject
          expect(response).to render_template(:new)
        end
      end
      context '職業がnil' do
        let(:params) { { user: attributes_for(:user, job: nil) } }
        it 'new画面をrender' do
          subject
          expect(response).to render_template(:new)
        end
      end
      context 'メールアドレスが型通りでない' do
        let(:params) { { user: attributes_for(:user, email: 'xxxxx') } }
        it 'new画面をrender' do
          subject
          expect(response).to render_template(:new)
        end
      end
    end
  end

  describe 'GET ＃editアクション' do
    subject { get :edit, params: params }
    context '正常' do
      let(:user) { create(:user) }
      let(:params) { { id: user.id, user: attributes_for(:user) } }
      it 'editのテンプレートをrenderする' do
        is_expected.to have_http_status(200)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'PATCH #updateアクション' do
    subject { patch :update, params: params }
    context '正常' do
      let(:user) { create(:user) }
      let(:params) { { id: user.id, user: attributes_for(:user, name: 'new name') } }
      it 'ユーザー情報更新、リダイレクト' do
        is_expected.to have_http_status(302)
        expect(user.reload.name).to eq 'new name'
        expect(response).to redirect_to "/users/#{user.id}"
      end
    end
    context '異常' do
      let(:user) { create(:user) }
      let(:params) { { id: user.id, user: attributes_for(:user, name: '') } }
      it 'ユーザー情報を更新できない(入力値が空)' do
        is_expected.to have_http_status(200)
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
    subject { delete :destroy, params: { id: user.id } }
    context '正常' do
      it 'ユーザーを削除できる' do
        expect { subject }.to change(User, :count).by(-1)
        expect(response.status).to be 302
      end
    end
  end
end
