class FilterService

  def initialize(filters)
    @filters = filters
  end

  def filter(profiles)
    profiles.map do |p|
      pass_filters(p)
    end
  end

  def pass_filters(profile)
    @filters.each do |filter|
      profile = pass_filter(filter, profile)
      break if profile.error.present?
    end
    profile
  end

  def pass_filter(filter, profile)
    value = eval("profile.#{filter['attribute']}")
    unless filter['expected'].is_a?(Array) && filter['expected'].include?(value) ||
           filter['expected'] == value
      profile.error = filter['error']
    end
    profile
  end
end
