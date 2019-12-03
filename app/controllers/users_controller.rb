# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  include UsersHelper

  require 'net/http'
  require 'json'
  require 'uri'
  # GET /users
  # GET /users.json
  def index
    @user = User.new
    @users = User.all
    @page = 1
    # ユーザー検索をしている
    session[:value] = params[:user]
    if session[:value].nil?
      session[:value] = { 'name' => '', 'email' => '', 'birth' => '', 'hobby' => '', 'job' => '' }
    end
    @user_value = session[:value]
    @user_params = session[:user]
    if params[:user]
      @users = @users.where(user_params_hash(params[:user]))
      session[:value] = params[:user]
    else
      params[:user] = @user_params
    end
    session[:user] = params[:user]

    # 総ユーザー数取得
    @users_num = @users.count.to_i
    paging
    @page = params[:id].to_i
    # kaminari
    @posts = User.all.page(params[:page]).per(10)
    @page_limit = 10

    @max_page_num = @users_num / @page_limit
    @max_page_num += 1 if (@users_num % @page_limit) > 0

    @start_page = if @page > @max_page_num - 2
                    @max_page_num - 4
                  elsif @page > 3
                    @page - 2
                  else
                    1
                  end

    @page_count = if @max_page_num > 4
                    5
                  else
                    @max_page_num
                  end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user_params = session[:user]
  end

  # GET 
  def api_show
    url = URI.parse("http://localhost:3000/api/v1/users/5")
    http = Net::HTTP.new(url.host, url.port)
    req = Net::HTTP::Get.new(url.path)
    res = http.request(req)
    @hash = JSON.parse(res.body)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :email, :sex, :birth, :hobby, :job)
  end

  def user_params_hash(param)
    response = {}
    response[:name] = param[:name] if param[:name].present?
    response[:email] = param[:email] if param[:email].present?
    response[:birth] = param[:birth] if param[:birth].present?
    response[:sex] = param[:sex] if param[:sex].present?
    response[:hobby] = param[:hobby] if param[:hobby].present?
    response[:job] = param[:job] if param[:job].present?
    response
  end
end
