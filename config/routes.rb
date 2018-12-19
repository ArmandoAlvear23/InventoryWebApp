Rails.application.routes.draw do

 # get '/', to: "home#index"
 # get 'home/users/sign_in'

 devise_for :users, path: '', path_names: { sign_in: '/signin', sign_out: 'logout'}, :controllers => { registrations: 'registrations'}, :skip => [:registrations]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  #get '/home', to: "home#home"


  as :user do
  get 'edit' => 'devise/registrations#edit', :as => 'edit_user_registration'    
  put 'users' => 'devise/registrations#update', :as => 'user_registration'            
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount PdfjsViewer::Rails::Engine => "/pdfjs", as: 'pdfjs'

  devise_scope :user do
  	authenticated :user do
  		root 'home#home', as: :authenticated_root
      resources :bes_assets
      resources :bes_cyber_assets
      resources :bes_cyber_systems
      resources :network_top_to_es_perimeters
      resources :ps_perimeters
      resources :ea_points
      resources :es_perimeters do
        get 'download'
      end
      resources :psp_diagrams_to_ps_perimeters
      resources :access_list_to_ea_points
  	end

  	unauthenticated do
  		root 'devise/sessions#new', as: :unauthenticated_root
  	end
  end

end
