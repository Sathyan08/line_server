class LinesController < ApplicationController

  def show

    begin
      requested_line = params[:id]

      Line.check_if_exceeds_line_count?(requested_line)
      @line = Line.find_from_redis(requested_line)
      render json: @line, status: :ok
    rescue StandardError => error
      status = (Line.exceeds_line_count?(requested_line) ? 413 : 500)
      render json: error.message, status: status
    end

  end

end
