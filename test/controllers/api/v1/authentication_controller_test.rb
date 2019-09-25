require 'test_helper'

class Api::V1::AuthenticationControllerTest < ActionDispatch::IntegrationTest
  test "POST#auth doesn't return the token if credential are invalid" do
    post api_v1_auth_path, as: :json
    assert_response :unauthorized
  end

  test "POST#auth return the token with expiration" do
    post api_v1_auth_path, as: :json,
      params: { email: 'admin@test.com', password: '123456' }
    assert_response :ok
  end
end