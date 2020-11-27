class FavoriteSerializer
  include FastJsonapi::ObjectSerializer
  attributes :place_id, :user_id
end
