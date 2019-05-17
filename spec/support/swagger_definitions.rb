module SwaggerDefinitions
  def self.swagger_definitions
    {
      user: user
    }
  end

  def self.user
    {
      type: :object,
      properties: {
        email: { type: :string },
        first_name: { type: :string },
        last_name: { type: :string },
        token: { type: :string }
      },
      required: %w[email first_name last_name]
    }
  end
end
