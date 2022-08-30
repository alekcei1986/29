#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
 set :database, {adapter: "sqlite3", database: "barbershop.db"}

class Client < ActiveRecord::Base
	validates :name, presence: true  #провиряет наличее записи (presence: true)
	validates :phone, presence: true
	validates :datestamp, presence: true
	validates :color, presence: true
	






end

class Barber < ActiveRecord::Base
end

before do
	@barbers = Barber.all

end	
get '/' do



	erb :index 
end

get '/visit' do

	@c = Client.new
	erb :visit
end

post '/visit' do

    @c = Client.new params[:client]
	if @c.save                                                                                   #- выполняет валидацию 
	#@username = params[:username] - усторевший способ 
	#@phone = params[:phone]
	#@datetime = params[:datetime]
	#@barber = params[:barber]
	#@color = params[:color]

	#c = Client.new
	##c.name = @username
	#c.phone = @phone
	#c.datestamp = @datetime
	#c.barber = @barber
	#c.color = @color
	#c.save # для записи данных команда 

	erb "<h2>Спасибо вы записались </h2>"
	 
		
	else
        @error = @c.errors.full_messages.first
		erb :visit
		
	end
end


get '/barber/:id' do
@barber = Barber.find(params[:id])



erb :barber
end

get '/bookings' do

	@clients = Client.order('created_at DESC')
	erb :bookings

end

get '/client/:id' do
	@client = Client.find(params[:id])
	erb :client
  end