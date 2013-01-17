require 'sinatra'
require 'haml'
require 'dm-core'
DataMapper.setup( :default, "sqlite3://#{Dir.pwd}/development.db" )

# Define the model
require 'dm-active_model'
class Comment
 include DataMapper::Resource
 include DataMapper::ActiveModel

 property :id, Serial
 property :text, String
end


get '/comments/new' do
  haml :form
end


module RoutingHelpers
  def comments_path(*)
    "/comments"
  end
end


require 'cell/base'
require "cell/rails/helper_api"
require "simple_form"

Cell::Base.append_view_path("cells")
 
class CommentCell < Cell::Base
  include Cell::Rails::HelperAPI
 
  self._helpers = RoutingHelpers
 
  def new
    @comment = Comment.new
    render
  end
end

Haml.init_rails(1)