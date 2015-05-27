require 'sinatra'
require 'pry'
require 'sinatra/reloader' if development?
require 'yahoofinance'

def get_standard_quotes(symbol)
  YahooFinance::get_standard_quotes(symbol)[symbol] rescue nil
end


get '/' do
  erb :home
end

get '/basic' do

  @operator = params[:operator]
    if @operator
       @first = params[:first].to_i
       @second = params[:second].to_i

    @result = case @operator
    when '+' then @first + @second
    when '-' then @first - @second
    when '*' then @first * @second
    when '/' then @first / @second
    end
  end
  erb :basic
end

get '/power' do

  @first = params[:first]

  if @first
    @first = params[:first].to_i
    @second = params[:second].to_i
    @result_power = (@first ** @second)
  end
  erb :power
end

get '/square_root' do
    @first = params[:first].to_i
    @result_square = Math.sqrt(@first)
erb :square_root
end

get '/trip' do
   @distance = params[:distance].to_f
 @mpg = params[:mpg].to_f
 @fppg = params[:fppg].to_f
 @speed = params[:speed]
 if @speed
   @hours = @distance / @speed.to_f
   @price = (@distance/@mpg)*@fppg
end
erb :trip
end

get '/bmi' do
  @measurement = params[:measurement]
  @weight = params[:weight].to_f
  @height = params[:height].to_f
  @result_bmi = @weight/@height**2
erb :bmi
end

get '/mortgage' do
  @principal = params[:principal].to_f
  @interest = params[:interest].to_f
  @payment_number = params[:payment_number].to_i
  if @principal && @interest && @payment_number
    @interest = @interest / 100 / 12
    x = ((1+@interest)**@payment_number).to_i
    @monthly_payment = (@principal * @interest * x / (x-1)).round(2)
  end
  erb :mortgage
end

get '/stocks' do
  @page = 'home'

  @data = params[:data]
  @result = get_standard_quotes(@data)

  erb :stocks
end