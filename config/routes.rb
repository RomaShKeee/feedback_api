Rails.application.routes.draw do
  resources :feedbacks, only: %i[index new create show] do
    collection do
      get :count
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
