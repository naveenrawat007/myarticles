Rails.application.routes.draw do
  devise_for :users
  namespace 'api' do
    namespace "v1" do
      resources :articles
      resources :people
      devise_for :users, controllers: { registrations: "api/v1/users/registrations" , sessions: "api/v1/users/sessions"}
      devise_scope :user do
        post "/users/verify_otp" => "users/registrations#verify_otp"
        post "/users/resend_otp" => "users/registrations#resend_otp"
        post "/users/forget_password" => "users/registrations#forget_password"
        put "/users/update_profile" => "users/registrations#update_profile"
        put "/users/reset_forget_password" => "users/registrations#reset_forget_password"
      end

      post "/get_articles_by_date" => "articles#find_articles_by_date"
      post "/get_articles_by_month" => "articles#find_articles_by_month"

    end
  end
end
