class BandsController < ApplicationController

  def index
    @bands = Band.all
    render :index
  end

  def show
    @band = Band.find_by(id: params[:id])
    render :show
  end

  def edit
    @band = Band.find_by(id: params[:id])
    render :edit
  end

  def update
    @band = Band.find_by(id: params[:id])

    if @band.update_attributes(band_params)
      render :show
    else
      redirect_to edit_band_url(@band)
    end
  end

  def destroy
    @band = Band.find_by(id: params[:id])
    if @band
      @band.destroy
    else
      return nil
    end
    redirect_to bands_url
  end

  private
  def band_params
    params.require(:band).permit(:name)
  end

end
