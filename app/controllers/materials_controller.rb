class MaterialsController < ApplicationController
  before_action :set_material, only: [:destroy, :show]

  def show
    @material = Material.find(params[:id])
    @course = @material.course
  end

  def destroy
    @material.destroy
    redirect_back(fallback_location: course_path(@material.course), notice: 'Material eliminado exitosamente.')
  end

  private

  def set_material
    @material = Material.find(params[:id])
  end

  def material_params
    params.require(:material).permit(:name, :description, :material_type_id, :document)
  end
end
