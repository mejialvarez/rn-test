require 'test_helper'

class Api::V1::Admin::UsersControllerTest < ActionDispatch::IntegrationTest
  test "GET#index return the users" do
    get api_v1_admin_users_path, headers: { "HTTP_AUTHORIZATION" => build_token_auth(users(:admin)) }
    body = JSON.parse(response.body)

    assert_equal 2, body.length
    assert_equal 'employee@test.com', body[0]['email']
  end

  test 'POST#create create a new user' do
    assert_difference 'User.count' do
      post api_v1_admin_users_path,
      as: :json,
      params: { user: { email: 'test@test.com', password: '1234567', full_name: 'test' } },
      headers: { "HTTP_AUTHORIZATION" => build_token_auth(users(:admin)) }
    end
    assert_response :created
  end

  test "POST#create doesn't create an user if the token is invalid" do
    user = users(:employee)
    assert_no_difference 'Register.count' do
      post(
        api_v1_admin_users_path,
        as: :json
      )
    end
    assert_response :unauthorized
  end

  test "POST#create doesn't create an user if the user isn't admin" do
    user = users(:employee)
    assert_no_difference 'Register.count' do
      post(
        api_v1_admin_users_path,
        as: :json,
        headers: { "HTTP_AUTHORIZATION" => build_token_auth(user) }
      )
    end
    assert_response :forbidden
  end

  test "POST#create doesn't create an user if the parameters are empty" do
    user = users(:employee)
    assert_no_difference 'Register.count' do
      post api_v1_admin_users_path, as: :json,
        headers: { "HTTP_AUTHORIZATION" => build_token_auth(users(:admin)) }
    end
    assert_response :unprocessable_entity
  end

  test 'PATCH#update update an user' do
    user = users(:employee)

    patch api_v1_admin_user_path(user),
    as: :json,
    params: { user: { email: 'update@test.com' } },
    headers: { "HTTP_AUTHORIZATION" => build_token_auth(users(:admin)) }
    assert_response :ok

    user.reload

    assert_equal 'update@test.com', user.email
  end

  test 'DELETE#detroy detroy an user' do
    user = users(:employee)
    delete api_v1_admin_user_path(user),
    as: :json,
    headers: { "HTTP_AUTHORIZATION" => build_token_auth(users(:admin)) }

    assert_response :no_content
  end


  
end