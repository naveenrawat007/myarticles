Rails.application.routes.draw do
  devise_for :users
  namespace 'api' do
    namespace "v1" do
      resources :articles
      resources :people
      devise_for :users, controllers: { registrations: "api/v1/users/registrations" , sessions: "api/v1/users/sessions"}
      devise_scope :user do
        post "/users/verify_otp" => "users/registrations#verify_otp"
      end
    end
  end
end
