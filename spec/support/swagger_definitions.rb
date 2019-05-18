module SwaggerDefinitions
  def self.swagger_definitions
    {
      user: user,
      avatar: avatar
    }
  end

  def self.user
    {
      type: :object,
      properties: {
        email: { type: :string },
        first_name: { type: :string },
        last_name: { type: :string },
        token: { type: :string },
        avatar: { '$ref': '#/definitions/avatar' }
      },
      required: %w[email first_name last_name avatar]
    }
  end

  def self.avatar
    {
      type: :object,
      properties: {
        url: { type: :string, 'x-nullable': true },
      },
      required: %w[url]
    }
  end
end
