# frozen_string_literal: true

class Api::UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]
  protect_from_forgery except: [:create]

  include UsersHelper

  # GET /api/v1/users
  def index
    @user = User.includes(:favfoods)
    @users = @user.all
    @users = @users.where('name = ?', params[:name]) if params[:name].present?
    @users = @users.where('email = ?', params[:email]) if params[:email].present?
    @users = @users.where('birth = ?', params[:birth]) if params[:birth].present?
    @users = @users.where('sex = ?', params[:sex]) if params[:sex].present?
    @users = @users.where('hobby = ?', params[:hobby]) if params[:hobby].present?
    @users = @users.where('job = ?', params[:job]) if params[:job].present?
    render json: @users.to_json(include: { favfoods: { only: :favorite_food } })
  end

  # POST /api/v1/users
  def create
    User.create(user_params)
  end

  # GET /api/v1/users/:id
  def show
    render json: @user.to_json(include: { favfoods: { only: :favorite_food } })
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
    @user = User.find(params[:id])
  rescue StandardError
    render json: 'エラー: ユーザーが存在しません', status: 404
  end

  def user_params
    params.require(:user).permit(:name, :email, :sex, :birth, :hobby, :job)
  end
end
