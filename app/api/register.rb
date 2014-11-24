module Register
  class API < Grape::API
    version 'v1', using: :path, vendor: 'register'
    format :json

    helpers do
      def current_user
        @current_user ||= User.authorize!(env)
      end

      def authenticate!
        error!('401 Unauthorized', 401) unless current_user
      end
    end
    
    resource 'register' do
      get :init_token do

      end

      get :auth_token do

      end
    end    
  end
end
