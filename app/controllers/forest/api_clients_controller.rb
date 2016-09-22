class Forest::ApiClientsController < Forest::BaseController
  def new_secret_key
    resources.each(&:generate_secret_key).map(&:save)
    render json: { success: "Secret Keys generated for #{resources.count} #{resource_name.titleize.pluralize resources.count}." }, status: 200
  end
end
