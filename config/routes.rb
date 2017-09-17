Rails.application.routes.draw do
  get  '/login'          => 'users#login'
  get  '/logout'         => 'users#logout'
  get  '/books/filtered' => 'books#filtered'
  get  '/books/sortby'   => 'books#sortby'

  # Em caso de erro ou tentativa de acessar uma página inválida retorna para a página principal
  resources :books do
    get  '*a', to: redirect('/books')
  end

  # Em caso de erro ou tentativa de acessar uma página inválida retorna para a página principal
  resources :users do
    get  '*a', to: redirect('/books')
  end

  root 'books#index'
end
