require "uri"
require "rack"

class URI::Generic
  def params
    Rack::Utils.parse_query(query)
  end

  # Returns true if this URI is the same or less specific than `oth` URI.
  def <=(oth)
    oth = URI(oth)
    oth.path.start_with?(path) && params <= oth.params
  end

  # Returns true if `oth` URI is the same or less specific than itself.
  def >=(oth)
    oth = URI(oth)
    path.start_with?(oth.path) && params >= oth.params
  end

  def >(oth) = URI(oth) <= self
  def <(oth) = URI(oth) >= self
end
