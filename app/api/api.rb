require 'tweetpost'
require 'associater'

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
         error!('404 Not Found', 404)
      end
    end

    resource :user_post do
      params do
        requires :auth_token, type: String
        requires :user_id, type: Integer
        requires :amazon_url, type: String
        requires :image
        requires :message, type: String
      end
      post :upload do
        begin
          user = User.find_by_id(params[:user_id])
          error!('401 Unauthorized', 401) unless user.authenticate!(params[:auth_token])
          token =  UserAuthToken.where(user_id: user.id).first
          fail if token.blank?

          read_image_data = params[:image].tempfile
          path = "#{Rails.root}/tmp/#{user.name}.jpg"
          image_file = File.open(path, 'w+b')
          image_file.write(read_image_data.read)
          image_file.close
          
          associate = Associate.where(user_id: user.id).first
          url = Associater.new.build(params[:amazon_url], associate.token)

          Tweetpost.new.build(
            token.token,
            token.token_secret,
            params[:message] + ' ' + url,
            File.open(path, 'r+b')
          )
          status 200
        rescue
          error!('400 Bad Request', 400)
        end
      end
    end

    resource :amazon do
      params do
        requires :auth_token, type: String
        requires :user_id, type: Integer
        requires :associate_id, type: String
      end
      post :enable do
        begin
          user = User.find_by_id(params[:user_id])
          error!('401 Unauthorized', 401) unless user.authenticate!(params[:auth_token])
          associate = Associate.where(user_id: user.id).first
          fail if associate.present?
          associate = Associate.new
          associate.create_associate(params[:associate_id], user)
          status 200
        rescue
          error!('400 Bad Request', 400)
        end
      end
    end
  end
end
