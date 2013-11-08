Stevedore::Application.routes.draw do

  namespace :v1 do
    get "_ping", to: "registry#ping"


    # Index
    # - repositories
    put "repositories/(:namespace/):repo_name", to: "repositories#create"
    delete "repositories/(:namespace/):repo_name", to: "repositories#destroy"
    put "repositories(/:namespace)/:repo_name/auth", to: "repositories#auth"



    put "/repositories(/:namespace)/:repo_name/images", to: "images#update"
    get "/repositories(/:namespace)/:repo_name/images", to: "images#show"


    get "users", to: "users#show"
    post "users", to: "users#create"
    put "users/username", to: "users#update"

    # get "search", to: "repositories#search


    # Registry
    
    get "images/:image_id/layer", to: "layers#show"
    put "images/:image_id/layer", to: "layers#update"

    put "images/:image_id/json", to: "image_json#update"
    get "images/:image_id/json", to: "image_json#show"

    get "images/:image_id/ancestry", to: "images#ancestry"

    put "images/:image_id/checksum", to: "checksums#update"

    get "repositories(/:namespace)/:repo_name/tags", to: "tags#index"
    get "repositories(/:namespace)/:repo_name/tags/:tag_name", to: "tags#show"
    delete "repositories(/:namespace)/:repo_name/tags/:tag_name", to: "tags#destroy"
    put "repositories(/:namespace)/:repo_name/tags/:tag_name", to: "tags#update"
    
  end
end
