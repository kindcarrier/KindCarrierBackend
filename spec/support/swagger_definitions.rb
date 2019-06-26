module SwaggerDefinitions
  def self.swagger_definitions
    {
      error: error,
      negotiation: negotiation,
      user: user,
      avatar: avatar,
      message: message,
      address: address
    }
  end

  def self.error
    {
      type: :object,
      properties: {
        message: { type: :string },
        code: { type: :string }
      },
      required: %w[message code]
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
        avatar: { '$ref' => '#/definitions/avatar' }
      },
      required: %w[email first_name last_name avatar]
    }
  end

  def self.message
    {
      type: :object,
      properties: {
        text: { type: :string },
        negotiation_id: { type: :integer },
        user_id: { type: :integer }
      },
      required: %w[text negotiation_id user_id]
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
        photo: { type: :string, 'x-nullable': true },
        description: { type: :string },
        service_cost: { type: :string },
        'type ': { type: :string, enum: %w[request offer] },
        address_from: { '$ref' => '#/definitions/address' },
        address_to: { '$ref' => '#/definitions/address' },
        owner_id: { type: :integer, 'x-nullable': true },
        accepter_id: { type: :integer, 'x-nullable': true }
      },
      required: %w[name photo description service_cost address_from address_to type owner_id accepter_id]
    }
  end

  def self.address
    {
      type: :object,
      properties: {
        country: { type: :string, 'x-nullable': true },
        city: { type: :string, 'x-nullable': true },
        state: { type: :string, 'x-nullable': true },
        street: { type: :string, 'x-nullable': true },
        latitude: { type: :number, 'x-nullable': true },
        longitude: { type: :number, 'x-nullable': true }
      },
      required: %w[country city state street latitude longitude]
    }
  end
end
