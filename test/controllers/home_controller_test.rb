require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client = create(:api_client)
  end

  test 'should return 200 with valid signature' do
    signed_request :get, root_url
    assert_response :success
  end

  test 'should return unauthorized without valid signature' do
    get root_url
    assert_response :unauthorized
  end

  def signed_request(method, url, options = {})
    send method, url, options.merge(headers: headers_for(url))
  end

  def headers_for(url)
    request = ActionDispatch::Request.empty
    request.request_method = 'GET'
    request.stubs(:fullpath).returns(url)
    request.env['CONTENT_TYPE'] = 'application/x-www-form-urlencoded'
    ApiAuth.sign!(request, @client.id, @client.secret_key).env
  end
end
