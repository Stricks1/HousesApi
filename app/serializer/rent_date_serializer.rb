class RentDateSerializer
  include FastJsonapi::ObjectSerializer
  attributes :place_id, :start_date, :end_date, :rent_price, :place
end
