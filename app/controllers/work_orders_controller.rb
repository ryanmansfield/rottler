class WorkOrdersController < ApplicationController
  def index
    @workorders = WorkOrder.all
    @technicians = Technician.all
  end
  # def show
  #   @work_order = WorkOrder.find(1)
  # end
end
