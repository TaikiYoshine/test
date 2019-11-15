# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '練習' do
    before do
      @params = { name: '佐々木',
                  email: 'sasaki@gmail.com',
                  birth: 1992 - 4 - 18,
                  sex: 'male',
                  hobby: '犬',
                  job: '破壊僧' }
    end

    it '1 + 1 = 2' do
      expect(1 + 1).to eq 2
    end

    context '最初のいっぽ' do
      it '値が空だとUser.newできない' do
        user = User.new
        expect(user).not_to be_valid
      end
      it '正常' do
        user = User.new(@params)
        expect(user.name).to eq '佐々木'
      end
    end
  end
end
