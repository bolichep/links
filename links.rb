require 'sinatra'
require 'sinatra/json'
require 'sequel'
require 'json'

DB = Sequel.connect('sqlite://api.db')

DB.create_table? :links do
    primary_key :id
    String :title
    String :description
    String :link
end

class Link < Sequel::Model
end

get '/links' do
    links = Link.all
    json links
end

post '/links' do
    data = JSON.parse(request.body.read)
    link = Link.create(title: data['title'],
                       description: data['description'],
                       link: data['link'])
    json link
end

put '/links/:id' do |id|
    data = JSON.parse(request.body.read)
    link = Link[id]
    link.update(title: data['title'],
                description: data['description'],
                link: data['link'])
    json link
end

delete '/links/:id' do |id|
    link = Link[id]
    link.delete
    json link
end
