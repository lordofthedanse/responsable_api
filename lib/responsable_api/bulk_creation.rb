# frozen_string_literal: true

module ResponsableAPI
  class BulkCreation
    attr_accessor :errors

    def initialize(bulk_create_params, klass)
      @params = bulk_create_params
      @errors = []
      @klass = klass
    end

    def call
      params.each do |param_set|
        record = @klass.new(param_set.except(:client_side_id))

        unless record.save
          errors << { id: param_set[:client_side_id], message: record.errors.full_messages.to_sentence,
                      code: 422 }
        end
      end
    end

    def errors?
      errors.present?
    end

    private

    attr_reader :params
  end
end
