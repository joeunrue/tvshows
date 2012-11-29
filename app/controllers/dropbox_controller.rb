require 'dropbox_sdk'

class DropboxController < ApplicationController
  def authorize
    if not params[:oauth_token] then
      dbsession = DropboxSession.new(Settings.dropbox_app_key,
                                     Settings.dropbox_app_secret)

      # serialize and save this DropboxSession
      session[:dropbox_session] = dbsession.serialize

      # pass to get_authorize_url a callback url that will return the user here
      redirect_to dbsession.get_authorize_url url_for(:action => 'authorize')
    else
      # the user has returned from Dropbox
      dbsession = DropboxSession.deserialize(session[:dropbox_session])
      # we've been authorized, so now request an access_token
      Settings.access_token = dbsession.get_access_token
      session[:dropbox_session] = dbsession.serialize

      redirect_to :action => 'upload'
    end
  end

  def upload
    # Check if user has no dropbox session...re-direct them to authorize
    return redirect_to(:action => 'authorize') unless session[:dropbox_session]

    dbsession = DropboxSession.deserialize(session[:dropbox_session])
    # raise an exception if session not authorized
    client = DropboxClient.new(dbsession, Settings.dropbox_access_type)
    info = client.account_info # look up account information

    if request.method != "POST"
      # show a file upload page
      render :inline =>
        "#{info['email']} <br/>
        <%= form_tag({:action => :upload}, :multipart => true) do %>
        <%= file_field_tag 'file' %><%= submit_tag %><% end %>"
      return
    else
      # upload the posted file to dropbox keeping the same name
      resp =
        client.put_file(params[:file].original_filename, params[:file].read)
      render :text => "Upload successful! File now at #{resp['path']}"
    end
  end
end
