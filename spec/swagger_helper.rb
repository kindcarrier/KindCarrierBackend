# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.swagger_root = Rails.root.to_s + '/swagger'
  config.swagger_docs = {
    '/swagger.json' => {
      swagger: '2.0',
      info: {
        title: 'API',
        version: 'v1'
      },
      paths: {},
      definitions: SwaggerDefinitions.swagger_definitions
    }
  }
end
