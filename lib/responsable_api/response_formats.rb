# frozen_string_literal: true

module ResponsableAPI
  module ResponseFormats
    def initiate_response
      @response = { data: nil, errors: [] }
    end

    def find_create_or_return_error(klass, params)
      object = klass.find_or_initialize_by(id: params[:id])

      if object.persisted?
        success_response(data: { id: object.id, created_at: object.created_at }, status: :ok)
      elsif object.update(params)
        success_response(data: { id: object.id, created_at: object.created_at }, status: :created)
      else
        formatted_error_response(message: object.errors.full_messages.join(", "), status: :unprocessable_entity, id: object&.id)
      end
    end

    def error_response(error: nil, status: nil)
      @response[:errors] << error if error

      render json: @response, status:
    end

    def formatted_error_response(message:, status:)
      error_response(error: { id: nil, message:, code: status }, status:)
    end

    def success_response(data: nil, status: :ok, jbuilder_view: nil)
      if jbuilder_view
        render jbuilder_view, status:, locals: { data: }
      else
        @response[:data] = data
        @response[:errors] = nil
        render json: @response, status:
      end
    end
  end
end
