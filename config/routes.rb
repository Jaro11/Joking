Rails.application.routes.draw do
  root 'jokes#show'
  get 'jokes/show', to: 'jokes#show'
end
