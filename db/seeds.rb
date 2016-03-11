# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
admin = User.create(username: "guest", password: "password", role: :guest)
user = User.create(username: "user", password: "password", role: :user)
guest = User.create(username: "admin", password: "password", role: :admin)

user_foo = Foo.create(title: "User Foo", user: user)
Bar.create(title: "User Bar", foo: user_foo)

admin_foo = Foo.create(title: "Admin Foo", user: admin)
Bar.create(title: "Admin Bar", foo: admin_foo)
