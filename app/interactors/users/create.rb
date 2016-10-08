class Users::Create
  include Interactor

  def call
    context.user = existing_user || new_user
    context.already_existing = existing_user.present?
  end

  private

    def existing_user
      @existing_user ||= User.find_by_device_id(context.device_id) if context.device_id.present?
    end

    def new_user
      User.create(device_id: context.device_id)
    end
end
