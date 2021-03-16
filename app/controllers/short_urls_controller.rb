# frozen_string_literal: false

class ShortUrlsController < ApplicationController
  before_action :set_short_url, only: %i[show edit update destroy]

  # GET /short_urls or /short_urls.json
  def index
    @new_short_url = ShortUrl.new
    @short_urls = ShortUrl.all
  end

  # GET /short_urls/1 or /short_urls/1.json
  def show
    @visit = ShortUrl.find_by(id: params[:id])
    @visit.visitor_shortened_urls.create(short_url: @visit, ip_request: request.remote_ip)
    redirect_to @visit.full_url
  end

  def info
    @visit = ShortUrl.includes(:visitor_shortened_urls).find_by(id: params[:short_url])
    redirect_to root_path, alert: 'URL not found.' unless @visit.present?
  end

  # GET /short_urls/new
  def new
    @short_url = ShortUrl.new
  end

  # GET /short_urls/1/edit
  def edit; end

  # POST /short_urls or /short_urls.json
  def create
    @short_url = ShortUrl.new(short_url_params)

    respond_to do |format|
      if @short_url.save
        format.html { redirect_to info_path(@short_url), notice: 'Short url was successfully created.' }
        format.json { render :show, status: :created, location: @short_url }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @short_url.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /short_urls/1 or /short_urls/1.json
  def update
    respond_to do |format|
      if @short_url.update(short_url_params)
        format.html { redirect_to @short_url, notice: 'Short url was successfully updated.' }
        format.json { render :show, status: :ok, location: @short_url }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @short_url.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /short_urls/1 or /short_urls/1.json
  def destroy
    @short_url.destroy
    respond_to do |format|
      format.html { redirect_to short_urls_url, notice: 'Short url was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_short_url
    @short_url = ShortUrl.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def short_url_params
    params.require(:short_url).permit(:original_url, :shortened_url, :full_url)
  end
end
