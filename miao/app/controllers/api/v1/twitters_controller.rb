##
# Author:: FuSheng Yang (mailto:sysuyangkang@gmail.com)
# Copyright:: Copyright (c) 2015 thecampus.cc
# License:: Distributes under the same terms as Ruby
# Api of users
class Api::V1::TwittersController < ApplicationController

  # 返回所有twitters
  def index
    page = params[:page]
    per_page = params[:per_page]
    offset = params[:offset]
    @twitters = Twitter.where(status: 1).page(page).per(per_page).padding(offset).order('id DESC')
    data = { twitters: @twitters, total_count: Twitter.all.count }
    render_success_json 'Twitter list.', :ok, data
  end

  # 返回用户的twitters
  def user_twitters
    page = params[:page]
    per_page = params[:per_page]
    offset = params[:offset]
    @user_twitters = @current_user.twitters.where(status: 1).page(page).per(per_page).padding(offset).order('id DESC')
    data = { user_twitters: @user_twitters, total_count: @current_user.twitters.count }
    render_success_json 'User twitters list.', :ok, data
  end

  # 返回用户相关的twitters
  def user_relation_twitters
    page = params[:page]
    per_page = params[:per_page]
    offset = params[:offset]
    # 包含关注者, 树洞
    follower_ids = @current_user.following_by_type('User').ids
    # @user_relation_twitters = Twitter.find_by_sql('SELECT * FROM twitters WHERE user_id IN (?) ORDER BY id DESC', follower_ids)
    @user_relation_twitters = Twitter.where('user_id IN (?)', follower_ids).page(page).per(per_page).padding(offset).order('id DESC')
    data = { user_relation_twitters: @user_relation_twitters }
    render_success_json 'User relation twitters.', :ok, data
  end
end