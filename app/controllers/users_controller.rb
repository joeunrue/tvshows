class UsersController < Devise::SessionsController
  def new
    render text: 'hey'
  end

  def create
    super
  end

  def update
    super
  end
end
