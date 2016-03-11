# Test for TryCatch

This is a Rails 4 app, running with SQLite3 database.

## How to run this application

1. Clone this repositiory

  ```
  git clone https://github.com/filabreu/trycatch_test.git
  ```

2. Go into application folder and install all gems dependencies

  ```
  cd trycatch_test
  bundle install
  ```

3. Create the database schema

  ```
  rake db:create && rake db:migrate
  ```

4. Check if all tests are running properly

  ```
  rspec
  ```

5. Load seed data

  ```
  rake db:seed
  ```

6. Now access the application API


## Authentication

All APIs must use Basic HTTP authentication

1. For admin user

  ```
  username: 'admin', password: 'password'
  ```

2. For default user

  ```
  username: 'user', password: 'password'
  ```

3. For guest user

  ```
  username: 'guest', password: 'password'
  ```

## Application APIs

### Foo

##### GET /foos
List all Foo records

##### GET /foo/:id
Show a specific Foo record

##### POST /foos
Create a Foo record
```
{ foo: { title: <string> }}
```

##### PUT /foos/:id
Update a Foo record
```
{ foo: { title: <string> }}
```

##### DELETE /foos/:id
Destroy a Foo record

### Bar

##### GET /foos/:foo_id/bars
List all Bar records for a Foo record

##### GET /foos/:foo_id/bars/:id
Show a Bar record for a Foo record

##### POST /foos/:foo_id/bars
Create a Bar record for a Foo record
```
{ bar: { title: <string> }}
```

##### PUT /foo/:foo_id/bars/:id
Update a Bar record for a Foo record
```
{ bar: { title: <string> }}
```

##### DELETE /foo/:foo_id/bars/:id
Destroy a Bar record for a Foo record 
