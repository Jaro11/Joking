Rails.application.routes.draw do
  root 'jokes#show' # Makes the JokesController#show action the homepage.
  get 'jokes/show', to: 'jokes#show' # Explicit route for fetching jokes.
end
