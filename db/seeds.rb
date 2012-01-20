# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Visibility.create name: "Publico", symbol: :public, description: "Todos podem ver";
Visibility.create name: "Privado", symbol: :private, description: "So logados podem ver";

Consumer.create([{
  # Bernardo Rufino
}, {
  # Rodolfo Pinotti
}, {
  # Yuri Oliveira
}]);

Salesperson.create([{
  # Rebeca Black
}, {
  # Fernanda Hock
}, {
  # Silvia Morrone
}]);

default_password = "1234";

User.create([{
  email: "bermonruf@gmail.com",
  first_name: "Bernardo",
  last_name:  "Rufino",
  password: default_password,
  profile: Consumer.find(1)
}, {
  email: "rodolfo@qualoo.com",
  first_name: "Rodolfo",
  last_name: "Pinotti",
  password: default_password,
  profile: Consumer.find(2)
}, {
  email: "yuri@qualoo.com",
  first_name: "Yuri",
  last_name: "Oliveira",
  password: default_password,
  profile: Consumer.find(3)
}, {
  email: "rebeca@black.com",
  first_name: "Rebeca",
  last_name: "Black",
  password: default_password,
  profile: Salesperson.find(1)
}, {
  email: "fernanda.hock@gmail.com",
  first_name: "Fernanda",
  last_name: "Hock",
  password: default_password,
  profile: Salesperson.find(2)
}, {
  email: "silviamo@hotmail.com",
  first_name: "Silvia",
  last_name: "Morrone",
  password: default_password,
  profile: Salesperson.find(3)
}]);



