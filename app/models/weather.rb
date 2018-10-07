class Weather < OpenStruct
  def self.rendered_fields
    [:condition, :wind_kph, :wind_dir, :temp_c]
  end
end
