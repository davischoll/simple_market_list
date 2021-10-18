# frozen_string_literal: true

require 'test_helper'

class MarketListsControllerTest < ActionDispatch::IntegrationTest
  test 'Should show Your Market List as title if access root' do
    get root_path
    assert_response :success
    assert_select 'h1', text: 'Suas listas de mercado'
  end

  test 'Should show your Market List as title if access specific url' do
    get market_lists_path
    assert_response :success
    assert_select 'h1', text: 'Suas listas de mercado'
  end

  test "Should show you don't have any list if don't have any list if access root" do
    get root_path
    assert_response :success
    assert_select 'p', text: 'Você ainda não possui nenhuma lista'
  end

  test "Should show you don't have any list if don't have any list if access specific url" do
    get market_lists_path
    assert_response :success
    assert_select 'p', text: 'Você ainda não possui nenhuma lista'
  end

  test "User should have new button on market list index" do
    get market_lists_path
    assert_response :success
    assert_select 'a', text: 'Nova Lista de Mercado'
  end

  test 'User should fill name and date on new form' do
    get new_market_list_path
    assert_response :success
    assert_select 'input[name=\'market_list[name]\']'
    assert_select 'input[name=\'market_list[market_date]\']'
    assert_select 'form[action=\'/market_lists\']'
  end

  test 'Should create a new market list if market date is filled' do
    assert_difference 'MarketList.count', 2 do
      post market_lists_path, params: { market_list: { name: 'My List', market_date: '2021-10-16' } }
      post market_lists_path, params: { market_list: { name: '', market_date: '2021-10-16' } }
    end
  end

  test 'Should show market date is required if it is empty' do
    assert_difference 'MarketList.count', 0 do
      post market_lists_path, params: { market_list: { name: 'My List', market_date: '' } }
      assert_select 'li', 'Market date can\'t be blank'
    end
  end
end
