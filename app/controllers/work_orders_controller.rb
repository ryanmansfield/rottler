class WorkOrdersController < ApplicationController
  def index
    @workorders = WorkOrder.all
    @technicians = Technician.all
  end
end
