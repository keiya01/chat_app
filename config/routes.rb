Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#top'
  get 'chatroom/new' => 'group#new'
  post 'chatroom/create' => 'group#create'
  get 'chatroom/:pass/login' => 'group#login'
  post 'chatroom/:pass/login_form' => 'group#login_form'
  post 'chatroom/:pass/logout' => 'group#logout'
  get 'chatroom/:pass' => 'group#show'

  get 'users/regist/:pass' => 'users#regist'
  post 'users/regist/:pass' => 'users#regist_form'
  post 'users/login/:pass' => 'users#login_form'
  get 'users/:id/edit' => 'users#edit'
  post 'users/:id/update' => 'users#update'


end
