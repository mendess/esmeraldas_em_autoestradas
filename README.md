# Notes

## app/models/

Stores the models

to make a new model use `rails generate model NAME [field:type...]`

`type` can be:
- string
- text
- binary
- integer
- boolean
- date
- time
- datetime
- timestamp
- primary_key

## app/controllers/

Stores the controllers

To make a new controller use `rails generate controller NAME [routes...]`

## app/views/

Stores the views

View names are tied to the controller method names

### app/views/[controller]/[action (controler_method)].html.erb

for example
```ruby
class NutritionistsController < ApplicationController
  def index
  end
end
```

will expect a `app/views/nutritionists/index.html.erb` file.

### templating language

`<% ruby %>`: Arbitrary ruby
`<%= ruby %>`: Arbitrary ruby that will resolve to content


## config/routes.rb

Stores the routes

`rake routes` lists all routes

# Questoes

- `rake routes` mostra muitas rotas que eu não defini. Posso remover? Devo remover?
- se quero ter uma rota para as fotos dos nutricionistas, devo fazer isso com o
    controller dos nutricionistas ou devo criar um controller dedicado a imagens
    (que eventualmente serviria para imagens do site todo? Nao sei se e boa idea)
