# Petite

[![Code Climate](https://codeclimate.com/github/andela-atemitope/Petite/badges/gpa.svg)](https://codeclimate.com/github/andela-atemitope/Petite) 
Bored with Sinatra? You are in the right place!
Petite is a [Domain_Specific-Language](http://en.wikipedia.org/wiki/Domain-specific_language) which uses the [MVC](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller) model for creating light weight web applications in Ruby with a [directory structure](http://www.tutorialspoint.com/ruby-on-rails/rails-directory-structure.htm) similar to Rails .

## Installation

Add this line to your application"s Gemfile to install the gem:

```ruby
gem "Petite", :git => "git@github.com:andela-atemitope/Petite.git"
```

And then execute:

    $ bundle

Example Usage is found in the spec folder [things_to_do]() , a posts sharing application.
Petite's folder structure is

## Controllers

Controllers are made up of one or more actions that are executed on request it either renders a template or redirects to another action. An action is defined as a public method on the controller, which will automatically be made accessible to the web-server through the Routes. It can send commands to the model to update the model's state (e.g., editing a document). It can also send commands to its associated view to change the view's presentation of the model

`ApplicationController` should inherit from `Petite::Controller` as seen in `application_controller.rb`
and all other controllers needed for your application can inherit from your `ApplicationController`  e.g  `SampleController`

```ruby
#application_controller.rb
class ApplicationController < Petite::Controller

end

#posts_controller.rb
class SampleController < ApplicationController
  def index #action method index, renders index.html.erb
    @sample = sample.all
  end
end
```

Actions, by default, render a template in the app/views directory corresponding to the name of the controller and action after executing code in the action. For example, the index action of the `SampleController` would render the template app/views/posts/index.html.erb by default after populating the @sample instance variable. By default controllers should be named in their pluralized form and their class should be displayed in [`CamelCase`](https://en.wikipedia.org/wiki/CamelCase)



## Responses

Each action results in a response, which holds the headers and document to be sent to the user's browser. The actual response object is generated automatically through the use of renders and redirects and requires no user intervention.


#### Parameters

All request parameters, whether they come from a GET or POST request, or from the URL, are available through the `params` method which returns a hash.  An example of parameters is obvious when we make a post request to a particular path to fetch an item like `/items?id=3`. Underneath, the id is passed as the parameter as a hash like ``{ "id => "3" }``


## Routes

Routes are HTTP methods paired with a URL matching patter, the first route that matches a request is invoked.
Route patterns may include named parameters, which can be gotten from the params hash:
They are defined in the `config/routes.rb` file path of your said application
The resources method is also available for you, it makes available all the routes written below `resources(:name)`
Where `name` is the name of the controller, and everything behind the `#` references the action methods defined in your controller.

```ruby
  resources(:name)
  # All routes below are made available by the resources method, but you have to define the methods in your controller.
  get("/#{name}", to: "#{name}#index")
  get("/#{name}/new", to: "#{name}#new")
  get("/#{name}/:id", to: "#{name}#show")
  get("/#{name}/edit/:id", to: "#{name}#edit")
  get("/#{name}/delete/:id", to: "#{name}#destroy")
  post("/#{name}", to: "#{name}#create")
  patch("/#{name}/:id", to: "#{name}#update")
  put("/#{name}/:id", to: "#{name}#update")
  post("/#{name}/:id", to: "#{name}#update")
end
```

In the case of a request being made to an undefined route a 404 page is rendered.

## Views

`Petite::Controller` sends response to the user either by making use of render method specified within your controller method or by inferring the template to display from the name of your controller.

The render method which enables rendering of ERB templates is automatically configured.
Objects can be passed from the controller to the view by either assigning them as instance variables or by passing the object as a parameter to the render method:

Having instance variable `@todo` makes `todo` object available to `views\todo\show.html.erb` and by default this is rendered without explicitly calling the render method.


```html
  Post Title: <%= post.title %>
```

Calling the render method and passing an object exposes the object to the view template.

```ruby
def show
  list = List.find(params["id"])
  render :show, post
end
```
(which should be the name of the folder that contains the template) and the action method which should be the name of the file template to be rendered)


The application.html.erb file located in your view should contain the basic layout for all your pages i.e `headers, footers` using the yield statement to reference the different individual content of the pages as shown below
```html
  <!DOCTYPE html>
  <html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>My New App</title>
  </head>
  <body>
    <%= yield %>
  </body>
  </html>
```
```ruby
def show
  @list = Todo.all
end
```



<!-- If render is called twice a DoubleRenderError is raised. -->

## Models

Models are Ruby classes located in the models folder each model class represents an object e.g Post model represents the Post object andits data structures. They talk to the database, store and validate data and perform the business logic.
All models should inherit from the `Petite::PetiteRecord`. The BaseModel comes with a host of methods for creating, saving, and finding data objects, all without having to use the structured query language. Also model classes should be named as a singular object.

Example model class displaying available methods:

```ruby
#post.rb file
class Post < Petite::PetiteRecord
  to_table :posts
  #to_table method infers that this model models posts table in DB located in db/app.sqlite3

  property :id, type: :integer, primary_key: true
  property :description, type: :text, nullable: false
  property :title, type: :text
  property :author, type: :text, nullable: false

  #property method defines the property of the object as columns in the posts table.
  #The first argument passed to the property method is taken as the table column name
  #The type hash is taken as the data-type for the column
  #The primary_key hash makes the particular column the primary key for the table
  #The nullable hash value is used to evaluate whether a column can have a null value or not

  create_table
  #create_table method creates the table with name from the to_table method and with the given properties above if it does not exist

  #Other methods available
end
```

## External Dependencies

These are listed below, with links and descriptions for each.

[sqlite3](https://github.com/sparklemotion/sqlite3-ruby) - Allows Ruby programs to interface with the SQLite3 database engine
[tilt](https://github.com/rtomayko/tilt) - Generic interface to multiple Ruby template engines
[bundler](https://github.com/bundler/bundler) - Bundler provides a consistent environment for Ruby projects by tracking and installing the exact gems and versions that are needed
[rake](https://github.com/ruby/rake) - Rake is a Make-like program implemented in Ruby
[rack](https://github.com/rack/rack) - Rack provides a minimal, modular and adaptable interface for developing web applications in Ruby
[rack-test](https://github.com/brynary/rack-test) - Rack::Test is a small, simple testing API for Rack apps
[minitest](https://github.com/seattlerb/minitest) - Minitest provides a complete suite of testing facilities supporting TDD, BDD, mocking, and benchmarking
[Pry](https://rubygems.org/gems/pry/versions/0.10.3) - An IRB alternative and runtime developer console



## Running Tests

All the tests can be found in the spec folder and can be found in the `spec` folder. The tests have been divided into respective folders with each tests in its respective folder

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rspec spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/andela-atemitope/Petite. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
