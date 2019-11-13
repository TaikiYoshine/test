# frozen_string_literal: true

require 'application_system_test_case'

class FavfoodsTest < ApplicationSystemTestCase
  setup do
    @favfood = favfoods(:one)
  end

  test 'visiting the index' do
    visit favfoods_url
    assert_selector 'h1', text: 'Favfoods'
  end

  test 'creating a Favfood' do
    visit favfoods_url
    click_on 'New Favfood'

    fill_in 'Favorite food', with: @favfood.favorite_food
    fill_in 'User', with: @favfood.user_id
    click_on 'Create Favfood'

    assert_text 'Favfood was successfully created'
    click_on 'Back'
  end

  test 'updating a Favfood' do
    visit favfoods_url
    click_on 'Edit', match: :first

    fill_in 'Favorite food', with: @favfood.favorite_food
    fill_in 'User', with: @favfood.user_id
    click_on 'Update Favfood'

    assert_text 'Favfood was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Favfood' do
    visit favfoods_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Favfood was successfully destroyed'
  end
end
