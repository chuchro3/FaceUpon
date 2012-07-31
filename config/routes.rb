FaceUpon::Application.routes.draw do

  get "division/show"

  get "findgroupon/show"

  resources :groupon_deal

  get "pages/callback"

  get "pages/home"

  get "division/show"
  get "division/autocomplete_division_name"

  match 'search', :to => 'groupon_deal#search'
  match 'view/:id', :to => 'groupon_deal#viewdeal'
  match 'buy/:id', :to => 'groupon_deal#buydeal'
  match 'logout', :to => 'pages#logout'

  root :to => 'pages#home'

end
