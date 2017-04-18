class JsController < ApplicationController
  def test
    file = params[:exact_file] || params[:file] + '.js'
    render plain: Rails.application.assets[file].to_s
  end
end
