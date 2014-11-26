module API
  class API < Grape::API
    version 'v1', using: :path, vendor: 'api'
    format :json

    resource :register do
      params do
        requires :name, type: String
        requires :twitter_token, type: String
        requires :twitter_token_secret, type: String
      end
      post :user do
        user = User.new
        user.create_user(params[:name])
        user_token = UserAuthToken.new
        user_token.create_twitter(
          params[:twitter_token],
          params[:twitter_token_secret],
          user
        )
        {
          auth_token: user.authentication_token,
          id: user.id
        }
      end

      post :token do
        
      end
    end

    resource :user_post do
      params do
        requires :auth_token, type: String
        requires :user_id, type: Integer
      end
      post :upload do
        begin
          user = User.find(params[:user_id])
          fail '401' unless user.authenticate!(params[:auth_token])
          status 200
        rescue
          error!('401 Unauthorized', 401)
        end
      end
    end
  end
end
