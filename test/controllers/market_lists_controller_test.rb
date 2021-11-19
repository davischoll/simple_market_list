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
    MarketList.stub :all, MarketList.none do
      get root_path
      assert_response :success
      assert_select 'p', text: 'Você ainda não possui nenhuma lista'
    end
  end

  test "Should show you don't have any list if don't have any list if access specific url" do
    MarketList.stub :all, MarketList.none do
      get market_lists_path
      assert_response :success
      assert_select 'p', text: 'Você ainda não possui nenhuma lista'
    end
  end

  test 'User should have new button on market list index' do
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
    follow_redirect!
    assert_select 'a', text: 'Nova Lista de Mercado'
    assert_select 'p', 'Nova lista criada com Sucesso'
  end

  test 'Should show market date is required if it is empty' do
    assert_difference 'MarketList.count', 0 do
      post market_lists_path, params: { market_list: { name: 'My List', market_date: '' } }
      assert_select 'li', 'Market date não pode ficar em branco'
    end
  end

  test 'Should list market list name and date on index' do
    get market_lists_path
    assert_response :success

    assert_select 'tr' do
      assert_select 'td', text: 'Market List One'
      assert_select 'td', text: '16/10/2021'
    end

    assert_select 'tr' do
      assert_select 'td', text: 'Market List Two'
      assert_select 'td', text: '16/10/2021'
    end
  end

  test 'Should show edit link on market list index' do
    get market_lists_path
    assert_response :success

    MarketList.all.each do |ml|
      assert_select "a[href='/market_lists/#{ml.id}/edit']"
    end
  end

  test 'User should see previous name and date on edit form' do
    market_list = market_lists(:one)

    get edit_market_list_path(market_list)
    assert_response :success

    assert_select 'input[name=\'market_list[name]\'][value=?]', market_list.name
    assert_select 'input[name=\'market_list[market_date]\'][value=?]', market_list.market_date.to_s
    assert_select "form[action=\'/market_lists/#{market_list.id}\']"
  end
end
