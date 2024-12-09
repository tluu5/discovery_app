module ImageManagementHelper
  def remove_images(location, image_ids)
    return unless image_ids.present?

    image_ids.each do |image_id|
      image = location.images.find_by(id: image_id)
      image&.purge
    end
  end
end
