class NutritionistsController < ApplicationController
  def index
    search_param = params[:search_param]
    location = params[:location]
    @nutritionists = if search_param or location
        where_clause = "tags.name ILIKE ? OR nutritionists.name ILIKE ? OR clinic ILIKE ?"
        # split the search params into words with % signs for ILIKE matching
        param_list = search_param.split.map { |n| "%#{n}%" }
        # make a where clause for each of the words in the search params
        sql = param_list.map { where_clause }.join(" OR ")
        # triplicate each param to match the where clause
        param_list = param_list.flat_map { |n| [n, n, n] }
        # add the sql code to the begining of the list
        param_list.prepend(sql)
        location = "%#{location}%"
        Nutritionist
          .left_joins(:tags)
          .distinct
          .where(param_list)
          .where(["city ILIKE :l OR street ILIKE :l", l: location])
      else
        Nutritionist.all
      end
  end

  def new; end

  def create
    if Nutritionist.new(nutr_params).save
      render "new"
    else
      render "index"
    end
  end

  private

  def nutr_params
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
