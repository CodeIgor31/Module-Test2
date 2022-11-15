# frozen_string_literal: true

require 'test_helper'

class ArraysControllerTest < ActionDispatch::IntegrationTest
  test 'should get input' do
    get arrays_input_url
    assert_response :success
  end

  test 'should get result' do
    get arrays_result_url
    assert_response :success
  end
end
