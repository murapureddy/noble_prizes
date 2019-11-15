Rails.application.routes.draw do
  root 'api/v1/winners#alphabetailc_order'
  namespace :api do
    namespace :v1 do
      resources :winners do
        get 'finding_year_and_category',on: :collection
        get 'alphabetailc_order',on: :collection
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
