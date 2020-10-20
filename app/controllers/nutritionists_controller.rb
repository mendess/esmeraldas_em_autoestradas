class NutritionistsController < ApplicationController
  def index
    search_param = params[:search_param]
    location = params[:location]
    @nutritionists = if search_param or location
      search_param = /#{search_param || ""}/i
      location = /#{location || ""}/i
      Nutritionist
        .select { |n| n.name.match? search_param or n.clinic.match? search_param }
        .select { |n| n.city.match? location or n.street.match? location }
    else
      Nutritionist.all
    end
  end

  def new

  end

  def create
    if Nutritionist.new(nutr_params).save
      render 'new'
    else
      render 'index'
    end
  end

  private def nutr_params
    params.require(:nutritionist).permit(
      :name,
      :number,
      :clinic,
      :street,
      :city,
      :personal_page,
      :price,
    )
  end
end
