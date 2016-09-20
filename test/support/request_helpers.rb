module RequestHelpers
  def auth_visit(method, url, options = {})
    AuthenticateRequest.any_instance.stubs(:authentic_request?).returns(true)
    send(method, url, options)
  end

  def json_response
    ActiveSupport::JSON.decode @response.body
  end
end
