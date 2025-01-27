require 'sinatra'
require 'active_support/all'

get '/' do
  erb :index
end

# Square
get '/square/new' do
  erb :square_form
end

get '/square/results' do
  @number = params[:number].to_f
  @square = @number ** 2
  erb :square_results
end

# Square Root
get '/square_root/new' do
  erb :square_root_form
end

get '/square_root/results' do
  @number = params[:number].to_f
  @square_root = Math.sqrt(@number)
  erb :square_root_results
end

# Random Number
get '/random/new' do
  erb :random_form
end

get '/random/results' do
  @min = params[:user_min].to_f
  @max = params[:user_max].to_f
  @random_number = rand(@min..@max)
  erb :random_results
end

# Payment
get '/payment/new' do
  erb :payment_form
end

get '/payment/results' do
  @apr = params[:apr].to_f / 100 / 12
  @years = params[:years].to_i
  @present_value = params[:present_value].to_f

  @n = @years * 12
  @numerator = @apr * @present_value
  @denominator = 1 - (1 + @apr)**-@n
  @payment = (@numerator / @denominator).to_fs(:currency)

  erb :payment_results
end

<h1>Calculate Monthly Payment</h1>
<form action="/payment/results">
  <div>
    <label for="apr">APR (Annual Percentage Rate):</label>
    <input id="apr" type="number" name="apr" step="0.01" required>
  </div>
  <div>
    <label for="years">Number of years remaining:</label>
    <input id="years" type="number" name="years" required>
  </div>
  <div>
    <label for="principal">Principal:</label>
    <input id="principal" type="number" name="present_value" step="any" required>
  </div>
  <button>Calculate monthly payment</button>
</form>
<a href="/">Go back</a>

# Payment form
get '/payment/new' do
  erb :payment_form
end

# Payment results
get '/payment/results' do
  # Extract parameters from form submission
  apr = params[:apr].to_f / 100 / 12
  years = params[:years].to_i
  present_value = params[:present_value].to_f

  # Calculate monthly payment
  n = years * 12
  numerator = apr * present_value
  denominator = 1 - (1 + apr)**-n
  @payment = (numerator / denominator).to_fs(:currency)

  erb :payment_results
end
