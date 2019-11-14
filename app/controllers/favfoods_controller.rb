# frozen_string_literal: true

class FavfoodsController < ApplicationController
  before_action :set_favfood, only: %i[show edit update destroy]

  # GET /favfoods
  # GET /favfoods.json
  def index
    @favfoods = Favfood.where(user_id: params[:user_id])
  end

  # GET /favfoods/1
  # GET /favfoods/1.json
  def show; end

  # GET /favfoods/new
  def new
    @favfood = Favfood.new
  end

  # GET /favfoods/1/edit
  def edit; end

  # POST /favfoods
  # POST /favfoods.json
  def create
    @favfood = Favfood.new(favfood_params)

    respond_to do |format|
      if @favfood.save
        format.html { redirect_to user_favfood_path(id: @favfood.id), notice: 'Favfood was successfully created.' }
        format.json { render :show, status: :created, location: @favfood }
      else
        format.html { render :new }
        format.json { render json: @favfood.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /favfoods/1
  # PATCH/PUT /favfoods/1.json
  def update
    respond_to do |format|
      if @favfood.update(favfood_params)
        format.html { redirect_to user_favfood_path(id: @favfood.id), notice: 'Favfood was successfully updated.' }
        format.json { render :show, status: :ok, location: @favfood }
      else
        format.html { render :edit }
        format.json { render json: @favfood.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /favfoods/1
  # DELETE /favfoods/1.json
  def destroy
    @favfood.destroy
    respond_to do |format|
      format.html { redirect_to user_favfoods_path, notice: 'Favfood was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_favfood
    @favfood = Favfood.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def favfood_params
    params.require(:favfood).permit(:favorite_food, :user_id)
  end
end
