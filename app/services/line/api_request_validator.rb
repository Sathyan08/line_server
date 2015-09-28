class Line

  class ApiRequestValidator

    def self.call(requested_line)
      self.check_if_exceeds_line_count?(requested_line)
      self.default_error
    end

    private

    def self.exceeds_line_count?(requested_line)
      line_number = requested_line.to_i
      line_number > Line.count_from_redis
    end

    def self.check_if_exceeds_line_count?(requested_line)
      if self.exceeds_line_count?(requested_line)
        message = "You requested line #{ requested_line }, but the max line count is only #{ Line.count_from_redis }"
        raise StandardError.new(message)
      end
    end

    def self.default_error
      message = "Your request did not return a valid line."
      raise StandardError.new(message)
    end

  end

end
