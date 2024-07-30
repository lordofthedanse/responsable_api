# frozen_string_literal: true
require 'rails'
require "responsable_api/version"
require "responsable_api/response_formats"
require "responsable_api/base_controller"
require "responsable_api/bulk_creation"

module ResponsableAPI
  class Error < StandardError; end
end
