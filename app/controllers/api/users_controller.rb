# frozen_string_literal: true

class Api::UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]
  protect_from_forgery except: [:create]

  include UsersHelper

  # GET /api/v1/users
  def index
    @users = User.all
    render json: @users
  end

  # POST /api/v1/users
  def create
    User.create(user_params)
  end

  # GET /api/v1/users/:id
  def show
    render json: @user
  end

  # PATCH/PUT /api/v1/users/:id
  def update
    @user.update(user_params)
  end

  # DELETE /api/v1/users/:id
  def destroy
    @user.destroy
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    if @user
    else
      render json: 'エラー: ユーザーが存在しません', status: 422
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :sex, :birth, :hobby, :job)
  end
end
