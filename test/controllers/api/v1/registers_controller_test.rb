require 'test_helper'

class Api::V1::RegistersControllerTest < ActionDispatch::IntegrationTest
  test "GET#report doesn't return statistic if the token is invalid" do
    get api_v1_registers_report_path
    assert_response :unauthorized
  end

  test "GET#report return statistic of the user registers" do
    get api_v1_registers_report_path,
      params: { start: "2019-09-15 21:00:00", end: "2019-09-15 23:00:00" },
      headers: { "HTTP_AUTHORIZATION" => build_token_auth(users(:employee)) }
    body = JSON.parse(response.body)

    assert_equal 2, body['hours']
    assert_equal 1, body['input_total']
    assert_equal 1, body['output_total']
    assert_equal 2, body['registers'].length
  end
end