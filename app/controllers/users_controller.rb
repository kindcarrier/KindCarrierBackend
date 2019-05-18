class UsersController < SmartController
  # rubocop:disable Rails/LexicallyScopedActionFilter
  skip_before_action :authenticate_user, only: [:create]
  # rubocop:enable Rails/LexicallyScopedActionFilter

  create allowed_params: %i[email first_name last_name password]
  update allowed_params: %i[first_name last_name avatar]
  index
  show
end
