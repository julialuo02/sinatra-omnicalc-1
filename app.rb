require "sinatra"
require "sinatra/reloader"

get("/") do
  erb(:square_form)
end

get('/square/new') do
  erb(:square_form)
end

get('/square/results') do
  @number = params[:square].to_f
  @square = @number * @number
  erb(:square_results)
end

get('/square_root/new') do
  erb(:square_root_form)
end

get('/square_root/results') do
  @number = params[:user_number].to_f
  @square_root = Math.sqrt(@number)
  erb(:square_root_results)
end

get '/payment/new' do
  erb :payment_form
end

get '/payment/results' do
  # Convert inputs to appropriate values
  apr_float = params[:apr].to_f / 100 / 12
  @apr = apr_float.to_fs(:percentage, precision: 4) # Format as percentage with 4 decimal places
  @years = params[:years].to_i
  @present_value = params[:present_value].to_f

  # Calculate monthly payment
  @n = @years * 12
  @numerator = apr_float * @present_value
  @denominator = 1 - (1 + apr_float)**-@n
  @payment = (@numerator / @denominator).to_fs(:currency)

  erb :payment_results
end


get('/random/new') do
  erb(:random_form)
end

get('/random/results') do
  @min = params[:user_min].to_f
  @max = params[:user_max].to_f
  @num = rand(@min..@max)
  erb(:random_results)
end
