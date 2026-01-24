class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])

    query = { client_id: ENV.fetch("THREADS_CLIENT_ID", nil), redirect_uri: threads_oauth_callback_url,
              scope: "threads_basic,threads_content_publish", response_type: "code", state: params[:id] }.to_param
    @thread_authorization_url = URI::HTTPS.build(host: "threads.net", path: "/oauth/authorize", query: query).to_s
  end

  def threads_auth
    redirect_to user_url(params[:state].presence) and return if params[:error] && params[:error] == "access_denied"

    auth_client = Threads::API::OAuth2::Client.new(client_id: ENV.fetch("THREADS_CLIENT_ID", nil),
                                                   client_secret: ENV.fetch(
                                                     "THREADS_CLIENT_SECRET", nil
                                                   ))
    response = auth_client.access_token(code: params[:code], redirect_uri: threads_oauth_callback_url)

    @account = ThreadsAccount.find_or_initialize_by(user_id: current_user_id, threads_user_id: response.user_id)
    @account.short_access_token = response.access_token
    @account.save!

    redirect_to share_user_url(params[:state].presence)
  end

  def share
    @user = User.find(params[:id])
  end

  # share_post_user_path
  def share_post
    @user = User.find(params[:id])

    @account = ThreadsAccount.find_by(user_id: current_user_id)
    client = Threads::API::Client.new(@account.tokens.symbolize_keys[:short_access_token])

    pending = client.create_thread(text: params[:text])

    client.publish_thread(pending.id)
    redirect_to collection_items_url, notice: "Successfully posted."
  rescue Faraday::ServerError => e
    redirect_to redirect_to user_url(@user), alert: e.inspect
  end
end
