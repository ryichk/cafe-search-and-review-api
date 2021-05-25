class TermsController < ApplicationController
  def index
    expires_in 100.hour
  end
end
