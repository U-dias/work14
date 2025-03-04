class PagesController < ApplicationController
  before_action :search

  def home
    @rooms = @q.result(distinct: true)
  end
  def search
    @q = Room.ransack(params[:q])
  end

end
