class ImageSerializer
  include FastJsonapi::ObjectSerializer
  attributes :place_id, :image_url
end