class LinesController < ApplicationController

  def show

    begin
      requested_line = params[:id]
      @line = Line.find_by_redis(requested_line)

      Line::ApiRequestValidator.call(requested_line) if @line.nil?

      render json: @line, status: :ok
    rescue StandardError => error
      status = Line::ApiStatusCode.call(requested_line) if @line.nil?
      render json: error.message, status: status
    end

  end

end
