# Vabaco Practical Assignment [![Main](https://github.com/shako502/VabacoAssignment/actions/workflows/main.yaml/badge.svg)](https://github.com/shako502/VabacoAssignment/actions/workflows/main.yaml)

This repository is for Practical assignment provided by Vabaco. The app is written on Ruby with Ruby on Rails framework. The app provides simple Post-Comments system and the API service.

The app is based on tasks provided in: [Practical Assignment](https://github.com/shako502/VabacoAssignment/VabacoTasks/Practical-Assignment.pdf)

## Setup

#### Prerequisites

The setups steps expect following tools installed on the system.

- Github
- Ruby [2.7.3](https://github.com/shako502/VabacoAssignment/blob/main/.ruby-version#L1)
- Rails [6.1.3](https://github.com/shako502/VabacoAssignment/blob/main/Gemfile#L7)
- PostgreSQL [12.8](https://www.postgresql.org/ftp/source/v12.8/)
- Bundler [2.2.25](https://github.com/shako502/VabacoAssignment/blob/main/Gemfile.lock#L319)
- Yarn

#### Clone the repository

```bash
git clone git@github.com:shako502/VabacoAssignment.git
```

#### Install Gems required by the app
```ruby
bundle
```

#### Install Javascript Packages
```bash
yarn
```

#### Edit Database configuration file as required
*Use any editor*

```bash
nano config/database.yml
```




#### Create and setup the database

```ruby
bundle e rails db:setup
bundle e rails db:migrate
```

#### Run Server
```ruby
bundle e rails server
```

#### You can access server to [http://localhost:3000](http://localhost:3000)


## REST API
The REST API to the app is described below.

## Endpoints

### Get Last 10 Post (mark_for_deletion=false)

`GET /api/v1/posts/`

    curl -X GET 'http://localhost:3000/api/v1/posts' \
    -i -H 'Accept: application/json'

### Response

    HTTP/1.1 200 OK
    Status: 200 OK
    Connection: close
    Content-Type: application/json

```json
{
    "status": "200",
     "data": [
        {
            "id": 17,
            "title": "Post Title",
            "body": "Post Body",
            "mark_for_deletion": false,
            "created_at": "2021-08-18T23:24:45.329+04:00"
        },
        ...
}
```
---
### Get Single Post

`GET /api/v1/posts/:post_id`

    curl -X GET 'http://localhost:3000/api/v1/posts/17' \
    -i -H 'Accept: application/json'

### Response

    HTTP/1.1 200 OK
    Status: 200 OK
    Connection: close
    Content-Type: application/json

```json
{
    "status": "200",
    "data": {
        "id": 17,
        "title": "Post Title",
        "body": "Post BOdy",
        "mark_for_deletion": false,
        "created_at": "2021-08-18T23:24:45.310+04:00"
    }
}
```
---
### Get Last 10 Comments on Post

`GET /api/v1/posts/:post_id/comments`

    curl -X GET 'http://localhost:3000/api/v1/posts/17/comments' \
    -i -H 'Accept: application/json'

### Response

    HTTP/1.1 200 OK
    Status: 200 OK
    Connection: close
    Content-Type: application/json

```json
{
    "status": "200",
    "data": [
        {
            "id": 45,
            "post_id": 17,
            "body": "comment",
            "created_at": "2021-08-22T20:59:28.786+04:00"
        },
        ...
}
```
---
### Write Comment on Post

`POST /api/v1/posts/:post_id/comments`

    curl -X POST 'http://localhost:3000/api/v1/posts/17/comments' \
    -i -H 'Content-Type: application/json' \
    -H 'Accept: application/json' \
    --data-raw '{
        "body": "New Comment"
    }'

### Response

    HTTP/1.1 201 Created
    Status: 201 Created
    Connection: close
    Content-Type: application/json

```json
{
    "status": "200",
    "data": {
        "id": 47,
        "post_id": 17,
        "body": "New Comment",
        "created_at": "2021-08-23T17:01:31.421+04:00"
    }
}
```
---
### Update Comment

`PUT /api/v1/posts/:post_id/comments/:comment_id`

    curl -X PUT 'http://localhost:3000/api/v1/posts/17/comments/47' \
    -i -H 'Content-Type: application/json' \
    -H 'Accept: application/json' \
    --data-raw '{
        "body": "Updated Comment"
    }'

### Response

    HTTP/1.1 200 OK
    Status: 200 OK
    Connection: close
    Content-Type: application/json

```json
{
    "status": "200",
    "data": {
        "id": 47,
        "post_id": 17,
        "body": "Updated Comment",
        "created_at": "2021-08-23T17:01:31.421+04:00"
    }
}
```
---
### Delete Comment

`DELETE /api/v1/posts/:post_id/comments/:comment_id`

    curl -i -X DELETE 'http://localhost:3000/api/v1/posts/17/comments/47'

### Response

    HTTP/1.1 200 OK
    Status: 200 OK
    Connection: close
    Content-Type: application/json

```json
{
    "status": "200"
}
```

## Utilized Stacks/Tools
- Ubuntu [20.04](https://releases.ubuntu.com/20.04/)
- Ruby [2.7.3](https://github.com/shako502/VabacoAssignment/blob/main/.ruby-version#L1)
- Rails [6.1.3](https://github.com/shako502/VabacoAssignment/blob/main/Gemfile#L7)
- PostgreSQL [12.8](https://www.postgresql.org/ftp/source/v12.8/)
- jQuery [3.6.0](https://jquery.com/download/)
- Bootstrap [5.0.1](https://getbootstrap.com/docs/5.1/getting-started/download/)
- Grape API [1.5.3](https://rubygems.org/gems/grape)
- Factory_Bot [6.2.0](https://rubygems.org/gems/factory_bot)
- Faker [2.18.0](https://rubygems.org/gems/faker)
- Rspec-rails [5.0.0](https://rubygems.org/gems/rspec-rails/versions/5.0.0)

## Development Timeline
#### Local Environment setup
3 - 4 Hours

#### Rails setup and generating app structure
1 Hour

#### Reading Ruby and Ruby On Rails documentation
All the time :relieved:

#### Creating controller for duplicate_counter
2 Hours

#### Creating general view for front-end
30 Minutes

#### Creating front-end for duplicate_counter page
- Writing markup
- Writing JS ( Ajax handlers, general code )
- Testing

1 - 2 Hours

#### Creating table view for posts and comments
- Writing markup
- Writing JS
- Testing tables and actions
2 Hours

#### Preparing Database for posts and comments
- Writing has_many, belongs to relationship 
- Updating Routes
- Populating DB with fake data
1 Hour

#### Creating CRUD controller for posts
2 - 3 Hours

#### Creating CRUD controller for comments
1 - 2 Hours

#### Implementing Grape API 
- Generating default structure
- Updating routes for the API
- Creating base controller for the API
1 Hour

#### Creating API endpoint for Posts
2 Hours

#### Creating API endpoint for Comments
1 Hour

#### Implementing Rspec test tool
- Setup and generate base config
- Writing API test cases
- Writing duplicate_count controller tests

2 - 3 Hours

#### Creating actions for GitHub
30 Minutes


## Contributing
Pull requests are welcome


## License
[MIT](https://github.com/shako502/VabacoAssignment/blob/main/LICENSE)