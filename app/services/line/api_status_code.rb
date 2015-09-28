class Line

  class ApiStatusCode

    def self.call(requested_line)
      line_count = Line.count_from_redis
      requested_line.to_i >  line_count ? 413 : 500
    end

  end

end
