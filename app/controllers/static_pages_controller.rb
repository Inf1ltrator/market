class StaticPagesController < ApplicationController
  
  def hello
  	render text: "hello world"
  end

end
