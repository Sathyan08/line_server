class LinesController < ApplicationController

  def show

    begin
      @line = Line.find(params[:id])
      render json: @line.line_text, status: :ok
    rescue StandardError => error
      if params[:id].to_i > Line.all.count
        render nothing: :true, status: 413
      else
        render json: error.message, status: 500
      end
    end

  end

end
