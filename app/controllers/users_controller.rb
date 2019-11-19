# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  include UsersHelper
  # GET /users
  # GET /users.json
  def index
    puts 'index!!!'
    @user = User.new
    @users = User.all
    @page = 1
    # ユーザー検索をしている
    if params[:user]
      if params[:user][:name].present?
        @users = @users.where(name: params[:user][:name])
      end
      if params[:user][:email].present?
        @users = @users.where(email: params[:user][:email])
      end
      if params[:user][:birth].present?
        @users = @users.where(birth: params[:user][:birth])
      end
      if params[:user][:sex].present?
        @users = @users.where(sex: params[:user][:sex])
      end
      if params[:user][:hobby].present?
        @users = @users.where(hobby: params[:user][:hobby])
      end
      if params[:user][:job].present?
        @users = @users.where(job: params[:user][:job])
      end
    end
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
  def show; end

  # GET /users/new
  def new
    puts 'new!'
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users
  # POST /users.json
  def create
    puts 'create!'
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
    puts 'update!'
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
end
