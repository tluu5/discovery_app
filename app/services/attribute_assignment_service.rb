class AttributeAssignmentService
  def initialize(location, params)
    @location = location
    @params = params
  end

  def call
    assign_activities
    assign_amenities
  end

  private

  def assign_activities
    if @params[:activity_names].present?
      activities = Attribute.where(name: @params[:activity_names], category: "Activity")
      @location.activities = activities
    else
      @location.activities.clear
    end
  end

  def assign_amenities
    if @params[:amenity_names].present?
      amenities = Attribute.where(name: @params[:amenity_names], category: "Amenity")
      @location.amenities = amenities
    else
      @location.amenities.clear
    end
  end
end
