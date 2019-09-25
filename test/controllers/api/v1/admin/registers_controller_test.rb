require 'test_helper'

class Api::V1::Admin::RegistersControllerTest < ActionDispatch::IntegrationTest
  test 'POST#create create a new register' do
    user = users(:employee)
    assert_difference 'Register.count' do
      post api_v1_admin_user_registers_path(user),
      as: :json,
      params: { register: { type: 'in', occurred_at: Time.current } },
      headers: { "HTTP_AUTHORIZATION" => build_token_auth(users(:admin)) }
    end
    assert_response :created
  end

  test "POST#create doesn't create a register if the token is invalid" do
    user = users(:employee)
    assert_no_difference 'Register.count' do
      post(
        api_v1_admin_user_registers_path(user),
        as: :json
      )
    end
    assert_response :unauthorized
  end

  test "POST#create doesn't create a register if the user isn't admin" do
    user = users(:employee)
    assert_no_difference 'Register.count' do
      post(
        api_v1_admin_user_registers_path(user),
        as: :json,
        headers: { "HTTP_AUTHORIZATION" => build_token_auth(user) }
      )
    end
    assert_response :forbidden
  end

  test "POST#create doesn't create a register if the parameters are empty" do
    user = users(:employee)
    assert_no_difference 'Register.count' do
      post api_v1_admin_user_registers_path(user), as: :json,
        headers: { "HTTP_AUTHORIZATION" => build_token_auth(users(:admin)) }
    end
    assert_response :unprocessable_entity
  end

  test "POST#create doesn't create a register if the user doesn't exists" do
    assert_no_difference 'Register.count' do
      post api_v1_admin_user_registers_path(-1), as: :json,
        headers: { "HTTP_AUTHORIZATION" => build_token_auth(users(:admin)) }
    end
    assert_response :not_found
  end

  test "GET#report return statistic of the user registers" do
    user = users(:employee)
    get report_api_v1_admin_user_registers_path(user),
      params: { start: "2019-09-15 21:00:00", end: "2019-09-15 23:00:00" },
      headers: { "HTTP_AUTHORIZATION" => build_token_auth(users(:admin)) }
    body = JSON.parse(response.body)

    assert_equal 2, body['hours']
    assert_equal 1, body['input_total']
    assert_equal 1, body['output_total']
    assert_equal 2, body['registers'].length
  end
end