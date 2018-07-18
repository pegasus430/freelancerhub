Rails.application.routes.draw do
  root 'homes#index'
  
  resources :coupons
  resources :works
  resources :educations
  resources :interviews do
    collection do
      get :student_applications
      get :job_filter
    end  
  end

  mount ActionCable.server => '/cable'
  mount StripeEvent::Engine, at: '/stripe/webhook'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount ImageUploader::UploadEndpoint => "/images/upload"

  resources :users do
    resources :employer_profiles
    resources :student_profiles
    resources :employers  do
      get :apply_job
      member do 
        get :send_application
      end
    end  
  end
  
  get 'signout' => 'sessions#destroy', as: :signout
  get 'signin' => 'sessions#new', as: :signin
  post 'signin' => 'sessions#create'
  get 'signup' => 'registrations#new', as: :signup
  post 'signup' => 'registrations#create'
  get 'employersignup' => 'registrations#employersignup', as: :employersignup
  post 'employersignup' => 'registrations#create'
  get 'studentsignup' => 'registrations#studentsignup', as: :studentsignup
  post 'studentsignup' => 'registrations#create'
  
  match 'auth/:provider/callback', to: 'sessions#create', :via => [:get, :post]
  match 'auth/failure', to: redirect('/'), :via => [:get, :post]
  
  resources :registrations, :sessions, :sites
  resources :students

  resources :employers  do
    resources :students do
      get :apply_job
      member do 
        get :send_application
      end    
    end    
  end

  resources :homes
  resources :users

  resources :conversations do 
    resources :photos
  end
  
  resources :personal_messages do
    collection do
      post :invite_to_student
    end
  end
  
  resources :episodes
  resources :contacts
  resources :blogs
  resource :subscription
  resource :card
  resources :photos
  resources :jobs

  
  resources :contacts, only: [:new, :create], path_names: { new: '' }, path: :contact_us
  
  resources :notifications do
    collection do
      post :mark_as_read
    end
  end
  
  resource :employer_wizards do
    get :step1
    get :step2
    get :step3
    get :step4
    post :validate_step
  end
  
  get 'tags/:tag', to: 'students#index', as: :tag
  get 'billing', to: 'subscriptions#billing', as: 'billing'
  get 'updateaccount', to: 'users#updateaccount', as: 'updateaccount'
  get 'manage', to: 'users#manage', as: 'manage'
  get 'faq', to: 'homes#faq', as: 'faq'
  get 'employerpricing', to: 'homes#employerpricing', as: 'employerpricing'
  get 'studentpricing', to: 'homes#studentpricing', as: 'studentpricing'
  get 'privacypolicy', to: 'homes#privacypolicy', as: 'privacypolicy'
  get 'thankyou', to: 'users#thankyou', as: 'thankyou'
  get 'thankyoustudent', to: 'students#thankyoustudent', as: 'thankyoustudent'
  get 'aboutus', to: 'homes#aboutus', as: 'aboutus'
  get 'updateuserinfo', to: 'users#updateuserinfo', as: 'updateuserinfo'
  get 'set_language', to: 'homes#set_language', as: 'set_language'
  post 'apply_coupon', to: 'subscriptions#apply_coupon', as: 'apply_coupon'
  post 'contracts', to: 'employers#contract'
end