# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Visibility.create name: "Publico", symbol: :public;
Visibility.create name: "Privado", symbol: :private;

Company.create(%w(Avon Jequiti Herbalife Natura Boticario).map{|name| {name: name}});
Category.create(%w(Cosmeticos Higiene Alimenticio).map{|name| {name: name}})
{
  1 => [1, 2],
  2 => [1],
  3 => [3],
  4 => [1, 2],
  5 => [1]
}.to_a.each do |(company_id, category_ids)|
  Company.find(company_id).update_attributes(category_ids: category_ids);
end

default_password = "1234";

User.create([{
  email: "bermonruf@gmail.com",
  first_name: "Bernardo",
  last_name:  "Rufino",
  password: default_password,
  profile: Consumer.create({
    location: Location.create({
      street: "Av. Adilson Seroa da Motta, 134",
      city: "Rio de Janeiro",
      state: "RJ",
      country: "Brasil"
    })
  })
}, {
  email: "rodolfo@qualoo.com",
  first_name: "Rodolfo",
  last_name: "Pinotti",
  password: default_password,
  profile: Consumer.create({
    location: Location.create({
      street: "Av. Borges de Medeiros",
      city: "Rio de Janeiro",
      state: "RJ",
      country: "Brasil"
    })
  })
}, {
  email: "yuri@qualoo.com",
  first_name: "Yuri",
  last_name: "Oliveira",
  password: default_password,
  profile: Consumer.create({
    location: Location.create({
      street: "Av. Armando de Lombardi, 493",
      city: "Rio de Janeiro",
      state: "RJ",
      country: "Brasil"
    })
  })
}, {
  email: "rebeca@black.com",
  first_name: "Rebeca",
  last_name: "Black",
  password: default_password,
  profile: Salesperson.create({
    location: Location.create({
      street: "Av. Olegario Maciel, 440",
      city: "Rio de Janeiro",
      state: "RJ",
      country: "Brasil"
    })
  })
}, {
  email: "fernanda.hock@gmail.com",
  first_name: "Fernanda",
  last_name: "Hock",
  password: default_password,
  profile: Salesperson.create({
    location: Location.create({
      street: "Av. Olegario Maciel, 518",
      city: "Rio de Janeiro",
      state: "RJ",
      country: "Brasil"
    })
  })
}, {
  email: "silviamo@hotmail.com",
  first_name: "Silvia",
  last_name: "Morrone",
  password: default_password,
  profile: Salesperson.create({
    location: Location.create({
      street: "Av. Sernambetiba, 2000",
      city: "Rio de Janeiro",
      state: "RJ",
      country: "Brasil"
    })
  })
}]);



