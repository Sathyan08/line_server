class LinesController < ApplicationController

  def show

    begin
      @line = Line.find(params[:id])
      render json: @line.line_text, status: :ok
    rescue StandardError => error
      status = (params[:id].to_i > Line.all.count ? 413 : 500)
      render json: error.message, status: status
    end

  end

end
