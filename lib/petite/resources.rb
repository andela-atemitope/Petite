module Petite
  class Router
    attr_reader :routes

    def root(address)
      get('/', to: address)
    end

    def resources(path)
      path = path.to_s
      get("/#{path}", to: "#{path}#index")
      get("/#{path}/new", to: "#{path}#new")
      get("/#{path}/:id", to: "#{path}#show")
      get("/#{path}/edit/:id", to: "#{path}#edit")
      delete("/#{path}/:id", to: "#{path}#destroy")
      post("/#{path}/", to: "#{path}#create")
      put("/#{path}/:id", to: "#{path}#update")
    end
  end
end
