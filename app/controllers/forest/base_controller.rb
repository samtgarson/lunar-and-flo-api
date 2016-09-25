class Forest::BaseController < ForestLiana::ApplicationController
  protected

    def resource_class
      @resource_class ||= self.class.name.demodulize.gsub(/Controller$/, '').classify.constantize
    end

    def resources
      @resources ||= resource_class.find(resource_ids)
    end

    def resource_ids
      @resource_ids ||= params.require(resource_name).permit![:data][:attributes][:ids]
    end

    def resource_name
      @resource_name ||= resource_class.name.underscore
    end
end
