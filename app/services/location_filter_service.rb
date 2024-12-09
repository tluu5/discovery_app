class LocationFilterService
  def initialize(locations, params)
    @locations = locations
    @params = params
  end

  def call
    filter_by_activity
    filter_by_amenity
    search_by_name
    paginate_locations
  end

  private

  def filter_by_activity
    if @params[:activities].present?
      activity_ids = Attribute.where(name: @params[:activities], category: 'activity').pluck(:id)
      @locations = @locations.joins(:location_attributes).where(location_attributes: { feature_id: activity_ids }).distinct
    end
    @locations
  end

  def filter_by_amenity
    if @params[:amenities].present?
      amenity_ids = Attribute.where(name: @params[:amenities], category: 'amenity').pluck(:id)
      @locations = @locations.joins(:location_attributes).where(location_attributes: { feature_id: amenity_ids }).distinct
    end
    @locations
  end

  def search_by_name
    if @params[:search].present?
      sanitized_search = ActiveRecord::Base.sanitize_sql_like(@params[:search])
      @locations = @locations.where("name ILIKE ?", "%#{sanitized_search}%")
    end
    @locations
  end

  def paginate_locations
    @locations.page(@params[:page]).per(10)
  end
end
