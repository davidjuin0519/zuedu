class LineItemSerializer < ActiveModel::Serializer
  attributes :id,
             :product_id,
             :product_detail_id,
             :product_detail_description,
             :product_name,
             :cart_id,
             :order_id,
             :is_paid,
             :price,
             :name,
             :birth,
             :gender,
             :gender_t,
             :ss_number,
             :school,
             :grade,
             :food_preference,
             :note,
             :parent_phone_number,
             :parent_email

  def product_id
    object.product_detail.product.id
  end

  def product_name
    object.product_detail.product.name
  end

  def product_detail_description
    object.product_detail.description
  end

  def gender_t
    I18n.t "activerecord.attributes.line_item.gender_value.#{object.gender}"
  end

  def price
    object.product_detail.price.to_i
  end

  def is_paid
    object.order&.transactions&.first&.params.present?
  end
end
