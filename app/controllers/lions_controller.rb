class LionsController < ApiController
  def show
    @lion = Lion.find(params[:id])

    render json: LionSerializer.new(@lion)
  end

  def index
    @lions = Lion.search(search_params)

    render json: LionsSerializer.new(@lions)
  end

  def create
    @image_set = ImageSet.find_by_id(creation_params[:primary_image_set_id])
    return error_not_found('image_set for lion creation not found') unless @image_set
    return error_invalid_resource('image_set already associated with lion') if @image_set.lion.present?

    @name = creation_params[:name]
    @lion = Lion.create_from_image_set(@image_set, @name)

    render json: LionSerializer.new(@lion)
  end

  private

  def creation_params
    params.require(:lion).permit(
      :primary_image_set_id,
      :name,
      :age,
      :gender,
      :organization_id
    )
  end

  def search_params
    params.permit(:age, :gender, :organization_id, :name)
  end
end
