class ResponsesController < ApplicationController
  def index
    @responses = Response.includes(:prompt).all
  end

  def show
    @response = Response.includes(:prompt).find(params[:id])
  end
end
