module SwaggerDefinitions
  def self.swagger_definitions
    {
      negotiation: negotiation,
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
        url: { type: :string, 'x-nullable': true }
      },
      required: %w[url]
    }
  end

  def self.negotiation
    {
      type: :object,
      properties: {
        name: { type: :string },
        photo: { type: :string },
        description: { type: :string },
        service_cost: { type: :string },
        country: { type: :string },
        city: { type: :string },
        state: { type: :string },
        street: { type: :string },
        latitude_from: { type: :number },
        longitude_from: { type: :number },
        latitude_to: { type: :number },
        longitude_to: { type: :number },
        type: { type: :string },
        owner: { '$ref': '#/definitions/user', 'x-nullable': true },
        accepter: { '$ref': '#/definitions/user', 'x-nullable': true }
      },
      required: %w[name photo description service_cost country
                   city state street latitude_from longitude_from latitude_to
                   longitude_to type owner]
    }
  end
end
