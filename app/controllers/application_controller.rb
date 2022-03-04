class ApplicationController < ActionController::Base

  UNPROCESSABLE_ENTITY = 422

  def hello
    render html: 'Hello world'
  end
end
