class UsersController < Devise::SessionsController
  # Disabled this since I realized after the fact I don't actually
  # want people to subscribe to my personal tvtorrents feed...
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
