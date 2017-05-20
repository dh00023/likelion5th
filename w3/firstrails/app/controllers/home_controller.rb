class HomeController < ApplicationController
  def index
  	@msg = "Hack Your Life!"
  end

  def result
  	results = %w(바보 멍청이 착함 똑똑함 잘생김 이쁨)
  	@result = results.sample(2)
  	@spoon = (1..10).to_a.sample(2)
  	@name = params[:username] #hash
  end
end
