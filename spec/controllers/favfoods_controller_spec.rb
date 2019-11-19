# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FavfoodsController, type: :controller do
  describe 'GET #index' do
    context '正常' do
      it '正常なレスポンス(200)' do

      end
      it 'user.idと表示されているfavfoodのfavfood.user_idが一致する' do

      end
    end
  end

  describe 'GET #new' do
    context '正常' do
      it '正常なレスポンス(200)' do

      end
    end
  end

  describe 'POST #create' do
    context '正常' do
      it '新しいfavfoodがsaveされる' do

      end
      it '登録されたfavfoodの詳細ページにリダイレクトする' do

      end

    end
  end

  describe 'GET #edit' do
    context '正常' do
      it '正常なレスポンス(200)'
    end
  end

  describe 'PATCH #update' do
    context '正常' do
      it '各favfoodの詳細ページにリダイレクトする' do

      end
      it 'favfoodを更新できる' do

      end
    end
  end

  describe 'GET #show' do
    context '正常' do
      it '正常なレスポンス(200)' do

      end
    end
  end

  describe 'DELETE #destroy' do
    context '正常' do
      it 'favfoodを削除できる' do

      end
      it '/users/:user_id/favfoodsにリダイレクトする' do
        
      end
    end
  end
end
