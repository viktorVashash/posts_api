Rails.application.routes.draw do
  get 'rails/s'
  namespace :api do
    namespace :v1 do
      resources :users,           only: %i[create update destroy]

      scope :autorization, controller: :autorization do
        post 'login'
        put  'logout'
      end

      resources :posts,           only: %i[index create show update destroy]
    end
  end
end
