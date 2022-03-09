class ApplicationController < ActionController::Base

  UNPROCESSABLE_ENTITY_STATUS = 422
  OK_STATUS = 200

  ARTICLES_PAGINATION_LIMIT = 10

  def hello
    render html: 'Hello world'
  end
end
