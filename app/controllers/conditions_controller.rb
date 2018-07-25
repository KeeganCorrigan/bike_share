class ConditionsController < ApplicationController
  def index
    @conditions = Condition.paginate(:page => params[:page], :per_page => 50)
  end

  def show
    @condition = Condition.find(params[:id])
  end
end
