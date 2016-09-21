module RequestAuthentication
  extend ActiveSupport::Concern

  protected

    def authenticate_request!
      render(json: { errors: ['Not Authenticated'] }, status: :unauthorized) and return unless authentic_request?
    end

    def authentic_request?
      AuthenticateRequest.call(request: request).success?
    end
end
