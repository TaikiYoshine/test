# frozen_string_literal: true

module UsersHelper
  def paging
    page_size = 10
    page_num = params[:id].nil? ? 0 : params[:id].to_i - 1
    @users = @users.order(:id).limit(page_size).offset(page_size * page_num)
  end
end
