class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def threads_auth

    auth_client = Threads::API::OAuth2::Client.new(client_id: ENV["THREADS_CLIENT_ID"], client_secret: ENV["THREADS_CLIENT_SECRET"])
    response = auth_client.access_token(code: params[:code], redirect_uri: threads_oauth_callback_url)

    access_token = response.access_token
    client = Threads::API::Client.new(access_token)

    pending = client.create_thread(text: "Hello again")
    resp = client.publish_thread(pending.id)

    puts resp.status

    redirect_to collection_items_url
    # redirect_to user_url(current_user)
  end

  def share
    @user = User.find(params[:id])

    query = { client_id: ENV["THREADS_CLIENT_ID"], redirect_uri: threads_oauth_callback_url, scope: "threads_basic,threads_content_publish", response_type: "code" }.to_param
    @thread_authorization_url = URI::HTTPS.build(host: "threads.net", path: "/oauth/authorize", query: query).to_s
  end
end
