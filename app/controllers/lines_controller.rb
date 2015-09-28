class LinesController < ApplicationController

  def show

    begin
      requested_line = params[:id]
      Line::ApiRequestValidator.call(requested_line)

      @line = Line.find_by_redis(requested_line)
      render json: @line, status: :ok
    rescue StandardError => error
      status = Line::ApiStatusCode.call(requested_line)
      render json: error.message, status: status
    end

  end

end
