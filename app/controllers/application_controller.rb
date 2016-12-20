require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do

  end

  get '/posts/new' do
    #this renders the view page with the form to fill out the info
    erb :new
  end

  post '/posts/new' do
    #extracting the form data and putting it in code and using it to create an instance of post class
    @post = Post.create(name: params["name"], content: params["content"])
    # show.erb shows the post that were created
    redirect '/posts'
  end

  get '/posts' do
    @posts = Post.all
    erb :index
  end

  get '/posts/:id' do
    @post = Post.find(params[:id])
    erb :show
  end

  get '/posts/:id/edit' do
    @post= Post.find(params[:id])
    erb :edit
  end

  patch '/posts/:id' do
    @post = Post.find(params[:id])
    @post.update(params[:post])
    redirect "/posts/#{@post.id}"
  end

  delete '/posts/:id/delete' do
    @post= Post.find(params[:id])
    @name = @post.name
    @post.destroy
    erb :delete
  end

end
