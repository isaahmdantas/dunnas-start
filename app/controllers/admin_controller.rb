class AdminController < DunnasAdmin::ApplicationController 
    protect_from_forgery prepend: true, with: :exception
    after_action :flash_to_headers

    helper ApplicationHelper, 
        DeviseHelper, 
        EnumI18nHelper, 
        FormErrorHelper, 
        LayoutsHelper


    def index 
    end

    def modulos 
    end

    def flash_to_headers
        return unless request.xhr?
        response.headers['X-Message'] = flash_message
        response.headers["X-Message-Type"] = flash_type.to_s
        flash.discard # don't want the flash to appear when you reload page
    end

    private
        def flash_message
            [:error, :warning, :notice].each do |type|
                return flash[type] unless flash[type].blank?
            end
        end

        def flash_type
            [:error, :warning, :notice].each do |type|
                return type unless flash[type].blank?
            end
        end
end