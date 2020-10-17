class NutritionistsController < ApplicationController
  def index
    search_param = params[:search_param]
    location = params[:location]
    @nutritionists = if search_param or location
      search_param = search_param&.downcase
      location = location&.downcase
      Nutritionist
        .select { |n| n.name.downcase.include? search_param || "" }
        .select { |n| n.city.downcase.include? location || "" }
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
