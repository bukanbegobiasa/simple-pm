Rails.application.routes.draw do
  root 'projects#index'
  get 'styleguide'                => 'styleguides#index',   as: :styleguide
  get 'projects/:id/detail'       => 'projects#detail',     as: :project_detail
  get 'users/search/:project_id'  => 'users#search',        as: :user_search
  get 'user/:user_id'             => 'users#show',          as: :user_show

  resources :projects do
    resources :jobs do
      resources :tasks
      resources :job_activities

      get   'milestone'       => 'jobs#milestone'
      get   'status'          => 'jobs#status'
      put   'status'          => 'jobs#update_status'
      patch 'status'          => 'jobs#update_status'
    end

    resources :user_projects
  end

  resources :roles
  resources :user_jobs

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

end
