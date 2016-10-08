module RequestHelpers
  def stub_request_authentication
    AuthenticateRequest.any_instance.stubs(:authentic_request?).returns(true)
  end

  def json_response
    ActiveSupport::JSON.decode @response.body
  end
end
