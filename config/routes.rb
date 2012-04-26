Quizmaker::Application.routes.draw do

  get "password_resets/new"

  # Match the home controller stuff
  
  match 'home' => 'home#index', :as => :home
  match 'about' => 'home#about', :as => :about
  match 'contact' => 'home#contact', :as => :contact
  match 'privacy' => 'home#privacy', :as => :privacy


  # Account creation
  match 'signup' => 'home#index'
  match 'login' => 'home#index'
  match 'reset_password' => 'home#index'
  match 'sessions/new' => 'home#index'
  # Account creation as an admin
  match 'user/new' => 'users#new', :as => :new_user
  

  # Account Management
  match 'user/edit' => 'users#edit', :as => :edit_current_user


  # Session Destruction
  match 'logout' => 'sessions#destroy', :as => :logout


  # Role routing
  match 'questions/writer_index' => 'questions#writer_index', :as => :write
  match 'questions/approver_index' => 'questions#approver_index', :as => :approve

  # Admin Panel
  match 'users/edit_roles' => 'users#edit_roles', :as => :edit_roles


  # Misc
  match 'questions/new' => 'questions#writer_index', :as => :write
  
  resources :quizzes, :events, :roles, :user_roles, :sessions, :users, :question_categories, :question_types, :sections, :questions, :password_resets
  
  resources :quizzes do
    collection { post :sort}
  end
  
  resources :questions do
    collection { post :sort}
  end
  
  # index root
  root :to => 'home#index'

end
