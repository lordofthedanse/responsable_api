# frozen_string_literal: true

module ResponsableAPI
  class BaseController < ApplicationController
    include ResponseFormats
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity_error
    rescue_from ActiveRecord::RecordNotFound do |exception|
      add_not_found_error(exception)
      error_response(status: :unprocessable_entity)
    end
    rescue_from CanCan::AccessDenied do |exception|
      Rails.logger.debug { "Access (CanCan) denied on #{exception.action} #{exception.subject.inspect}" }
      render json: @response, status: :unauthorized
    end

    around_action do |_contr, action|
      action.call

      @response[:errors] = nil if @response[:errors] && @response[:errors].empty?
    end

    private

    def resource
      @resource ||= params[:controller].classify.split("API::")[1].constantize.find(params[:id])
    end

    def validation_error_response(obj)
      error_response(error: validation_error(obj), status: :unprocessable_entity)
    end

    def validation_error(obj, code: 422)
      { id: obj&.id, message: obj.errors.full_messages.to_sentence, code: }
    end

    def unprocessable_entity_error(exception)
      @response[:errors] << validation_error(exception.record)
    end

    def add_not_found_error(exception)
      @response[:errors] << { id: nil, message: exception.message, code: 422 }
    end
  end
end
