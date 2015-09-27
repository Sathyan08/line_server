class LinesController < ApplicationController

  def show
    # @line = Line.find(params[:id])

    # if @line.present
    #   render json: @line.line_text, status: :ok
    # else
    #   render nothing: :true, status: :bad_request
    # end
    begin
      @line = Line.find(params[:id])
      render json: @line.line_text, status: :ok
    rescue
      render nothing: :true, status: 413
    end

  end

end
