Rails.application.routes.draw do
  root 'lotto#index' 
  get 'result' => 'lotto#pick_and_check'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
