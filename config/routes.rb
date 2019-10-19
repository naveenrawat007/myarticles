Rails.application.routes.draw do
  namespace 'api' do
    namespace "v1" do
      resources :articles
      resources :people
      devise_for :users, controllers: { registrations: "api/v1/user/registrations" }
    end
  end
end
