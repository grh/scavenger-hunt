Rails.application.routes.draw do
  ###########################################################################
  # Routes take the form                                                    #
  #   http-request-method '/url', to: 'controller#action', as: named_route  #
  # where 'named_route' is usually in the form of action_controller.        #
  # Request methods for this application are limited to either GET or POST. #
  ###########################################################################

  #############################################################
  # HTML ROUTES - HTML IS RENDERED AND NO MODIFICATIONS OCCUR #
  #############################################################

  # public pages
  get '/', to: 'html#home', as: :root
  get '/about', to: 'html#about', as: :about
  get '/docs/user', to: 'html#user_doc', as: :user_doc
  get '/docs/developer', to: 'html#developer_doc', as: :developer_doc
  get '/signup', to: 'html#new_user_form', as: :signup_form
  get '/user/new_user', to: 'html#new_user_form', as: :new_user_form

  # participant pages
  get '/login', to: 'html#login_form', as: :login_form
  get '/user/:id', to: 'html#show_user', as: :show_user
  get '/user/:id/edit', to: 'html#edit_user_form', as: :edit_user_form
  get '/event/new_event', to: 'html#new_event_form', as: :new_event_form
  get '/event/:id', to: 'html#show_event', as: :show_event
  get '/join/:event_id', to: 'users#join_event', as: :join_event
  get '/visit/:tag', to: 'users#visit_location', as: :visit_location
  get '/user/:id/delete', to: 'users#delete_user', as: :delete_user

  # owner pages
  get '/event/:id/edit', to: 'html#edit_event_form', as: :edit_event_form
  get '/location/new_location_form', to: 'html#new_location_form', as: :new_location_form
  get '/location/:id', to: 'html#show_location', as: :show_location
  get '/location/:id/edit', to: 'html#edit_location_form', as: :edit_location_form

  # admin pages
  get '/events', to: 'html#show_all_events', as: :show_all_events
  get '/locations', to: 'html#show_all_locations', as: :show_all_locations
  get '/users', to: 'html#show_all_users', as: :show_all_users
  get '/setup', to: 'html#view_setup_form', as: :view_setup_form

  ###############################################################
  # NORMAL ROUTES - NOTHING RENDERED; MODIFICATIONS MIGHT OCCUR #
  ###############################################################

  # public routes
  post '/user/create_user', to: 'users#create_user', as: :create_user
  post '/user/:id/update', to: 'users#update_user', as: :update_user
  post '/session/create', to: 'sessions#create_session', as: :create_session

  # participant routes
  get '/logout', to: 'sessions#update_session', as: :logout
  get '/leave/:event_id', to: 'users#leave_event', as: :leave_event

  # owner routes
  post '/event/create_event', to: 'events#create_event', as: :create_event
  post '/event/:id/update', to: 'events#update_event', as: :update_event
  get '/event/:id/delete', to: 'events#delete_event', as: :delete_event
  post '/location/create_location', to: 'locations#create_location', as: :create_location
  post '/location/:id/update', to: 'locations#update_location', as: :update_location
  get '/location/:id/delete', to: 'locations#delete_location', as: :delete_location
  
  # admin routes
  post '/setup', to: 'options#update_options', as: :update_options
end
