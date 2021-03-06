class ProductSerializer < ActiveModel::Serializer
  attributes :id, 
             :name, 
             :subtitle,
             :description, 
             :dimension,
             :target,
             :pricing,
             :cover_image_url,
             :outline_image_url,
             :dimension_image_url,
             :activityUrl,
             :product_details,
             :detailimage
  def product_details
    object.product_details.sort.map do |pd|
      ProductDetailSerializer.new pd
    end
  end
end
