class LinesController < ApplicationController


  def show
    @line = Line.find(params[:id])

    render nothing: true, status: :ok
  end

end
