class SubscriptionsController < ApplicationController
  load_and_authorize_resource
  def create
    current_user.subscriptions.create(
      :show_id => params[:show_id],
      :file_format_string => params[:file_format]
    )

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.destroy

    respond_to do |format|
      format.js
    end
  end
end
