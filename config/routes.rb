Rails.application.routes.draw do
  root 'projects#index'
  get 'styleguide'                => 'styleguides#index',   as: :styleguide
  get 'projects/:id/detail'       => 'projects#detail',     as: :project_detail
  get 'users/search/:project_id'  => 'users#search',        as: :user_search
  get 'user/:user_id'             => 'users#show',          as: :user_show

  get 'projects/:id/summary/user' => 'projects#user_summary',     as: :user_summary
  get 'projects/:id/summary'      => 'projects#project_summary',  as: :project_summary

  resources :projects do
    resources :jobs do
      resources :tasks do
        get   'finish'          => 'tasks#finish',       as: :finish
      end
      resources :job_activities

      get   'milestone'       => 'jobs#milestone'
      get   'status'          => 'jobs#status'
      put   'status'          => 'jobs#update_status'
      patch 'status'          => 'jobs#update_status'
    end

    post  'jobs/search'       => 'jobs#search',       as: :jobs_search
    resources :user_projects
  end

  resources :roles
  resources :user_jobs

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

end
