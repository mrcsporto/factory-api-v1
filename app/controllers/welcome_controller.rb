class WelcomeController < ApplicationController
  include ActionView::Rendering
  def index
    render :index
  end
end

