class AuthenticateRequest
  include Interactor

  context_requires :request

  delegate :request, to: :context

  def call
    context.fail! unless authentic_request?
  end

  private

    def authentic_request?
      current_client.present? && ApiAuth.authentic?(request, current_client.secret_key)
    end

    def current_client
      @current_client ||= ApiClient.find_by_id ApiAuth.access_id(request)
    end
end
