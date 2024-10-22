class MaterialsController < ApplicationController
    before_action :set_material, only: [:destroy]
  
    def destroy
      @material.destroy
      redirect_back(fallback_location: course_path(@material.course), notice: 'Material eliminado exitosamente.')
    end
  
    private
  
    def set_material
      @material = Material.find(params[:id])
    end
  end
  
