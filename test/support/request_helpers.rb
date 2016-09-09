module RequestHelpers
  def auth_visit(method, url, options = {})
    send(method, url, options.merge(headers: auth_header))
  end

  def auth_header
    { 'Authorization' => JsonWebToken.encode(user_id: @user.id), as: :json }
  end

  def json_response
    ActiveSupport::JSON.decode @response.body
  end
end
