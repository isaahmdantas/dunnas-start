Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root to: 'admin#index'

  mount Ckeditor::Engine => '/ckeditor'
  mount DunnasEndereco::Engine, at: "/localizacao"
  mount DunnasAdmin::Engine, at: "/autenticacao"
  

  get 'wp-login.php', to: redirect('/404')
  match '404', :to => 'errors#not_found', :via => :all
  match '422', :to => 'errors#unacceptable', :via => :all
  match '500', :to => 'errors#internal_server_error', :via => :all

  
  match '/admin/audits/show', controller: 'admin/audits', action: 'show', via: [:get]

  
end
