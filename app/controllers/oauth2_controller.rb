require "google/api_client/client_secrets"
require "google/apis/calendar_v3"

class Oauth2Controller < ApplicationController
  def authorize
    client_secrets = Google::APIClient::ClientSecrets.load

    auth_client = client_secrets.to_authorization
    auth_client.update!(
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY,
      redirect_uri: oauth2_callback_url,
      access_type: :offline,
      additional_parameters: {
        approval_prompt: :force
      }
    )

    auth_uri = auth_client.authorization_uri.to_s
    redirect_to auth_uri
  end

  def callback
    client_secrets = Google::APIClient::ClientSecrets.load
    auth_client = client_secrets.to_authorization
    auth_client.update!(
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY,
      redirect_uri: oauth2_callback_url,
      access_type: :offline
    )
    auth_client.code = params[:code]
    auth_client.fetch_access_token!

    render plain: "access_token: #{auth_client.access_token}\nrefresh_token: #{auth_client.refresh_token}"
  end
end
