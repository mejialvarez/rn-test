Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      namespace :admin do
        resources :users, except: :show do
          resources :registers, only: [:create] do
            get :report, on: :collection
          end
        end
      end

      get 'registers/report', to: 'registers#report'

      post :auth, to: 'authentication#auth'
    end
  end
end
