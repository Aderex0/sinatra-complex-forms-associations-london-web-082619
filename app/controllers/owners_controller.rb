class OwnersController < ApplicationController

  #CREATE 

  get '/owners/new' do
    @pets = Pet.all  
    erb :'/owners/new'
  end

  post '/owners' do 
    @owner = Owner.create(params[:owner])

    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end

    redirect "/owners/#{@owner.id}"
  end

  #READ

  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index' 
  end

  get '/owners/:id' do 
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  #UPDATE

  get '/owners/:id/edit' do 
    @owner = Owner.find(params[:id])
    erb :'/owners/edit'
  end

  patch '/owners/:id' do 
    if !params[:owner].keys.include?("pet_ids")
      params[:owner]["pet_ids"] = []
    end

    @owner = Owner.find(params[:id])
    @owner.update(params["owner"])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    redirect "owners/#{@owner.id}"
    
  end
end