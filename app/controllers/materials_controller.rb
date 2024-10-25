class MaterialsController < ApplicationController
  before_action :set_course, only: [:new, :create, :upload, :process_upload]
  before_action :set_material, only: [:show, :destroy]

  def upload
    @material = @course.materials.build
  end

  def process_upload
    @material = @course.materials.build(material_params)
  
    if @material.save
      Rails.logger.info "Material guardado correctamente en el curso #{@course.title} con ID: #{@course.id}"
      redirect_to @course, notice: 'Material subido exitosamente.'
    else
      Rails.logger.error "Error al guardar el material: #{@material.errors.full_messages.join(', ')}"
      render :upload, alert: @material.errors.full_messages.join(', ')
    end
  end

  def show
    @course = @material.course
  end

  def destroy
    course = @material.course
    @material.destroy
    redirect_to course_path(course), notice: 'Material eliminado exitosamente.'
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_material
    @material = Material.find(params[:id])
  end

  def material_params
    params.require(:material).permit(:name, :description, :material_type_id, :document)
  end
end
