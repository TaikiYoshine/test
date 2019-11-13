# frozen_string_literal: true

require 'test_helper'

class FavfoodsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @favfood = favfoods(:one)
  end

  test 'should get index' do
    get favfoods_url
    assert_response :success
  end

  test 'should get new' do
    get new_favfood_url
    assert_response :success
  end

  test 'should create favfood' do
    assert_difference('Favfood.count') do
      post favfoods_url, params: { favfood: { favorite_food: @favfood.favorite_food, user_id: @favfood.user_id } }
    end

    assert_redirected_to favfood_url(Favfood.last)
  end

  test 'should show favfood' do
    get favfood_url(@favfood)
    assert_response :success
  end

  test 'should get edit' do
    get edit_favfood_url(@favfood)
    assert_response :success
  end

  test 'should update favfood' do
    patch favfood_url(@favfood), params: { favfood: { favorite_food: @favfood.favorite_food, user_id: @favfood.user_id } }
    assert_redirected_to favfood_url(@favfood)
  end

  test 'should destroy favfood' do
    assert_difference('Favfood.count', -1) do
      delete favfood_url(@favfood)
    end

    assert_redirected_to favfoods_url
  end
end
