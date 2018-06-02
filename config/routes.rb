Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'group#new'
  post 'chatroom/create' => 'group#create'
  get 'chatroom/login' => 'group#login'
  post 'chatroom/login_form' => 'group#login_form'
  post 'chatroom/:pass/logout' => 'group#logout'
  get 'chatroom/:pass' => 'group#show'

  get 'users/regist/:pass' => 'users#regist'
  post 'users/regist/:pass' => 'users#regist_form'
  get 'users/edit' => 'users#edit'
  post 'users/update' => 'users#update'


end
