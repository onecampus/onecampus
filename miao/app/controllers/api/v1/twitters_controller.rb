##
# Author:: FuSheng Yang (mailto:sysuyangkang@gmail.com)
# Copyright:: Copyright (c) 2015 thecampus.cc
# License:: Distributes under the same terms as Ruby
# Api of twitters
class Api::V1::TwittersController < ApplicationController

  before_action :set_twitter, only: [:show, :update, :destroy]

  # 返回所有twitters, 禁用
=begin
  def index
    page = params[:page]
    per_page = params[:per_page]
    offset = params[:offset]
    @twitters = Twitter.where(status: 1).page(page).per(per_page).padding(offset).order('id DESC')
    data = { twitters: @twitters, total_count: Twitter.all.count }
    render_success_json 'Twitter list.', :ok, data
  end
=end

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
    follower_ids.push @current_user.id  # 包括当前用户的twitter
    @user_relation_twitters = Twitter.where('user_id IN (?)', follower_ids).page(page).per(per_page).padding(offset).order('id DESC')
    data = { user_relation_twitters: @user_relation_twitters }
    render_success_json 'User relation twitters.', :ok, data
  end

  def create
    # picture_ids 图片ids
    twitter_params[:user_id] ||= @current_user.id
    twitter_params[:status] = 1
    t = Twitter.new(twitter_params)
    if t.save
      picture_ids = params[:picture_ids]
      picture_ids.each do |pid|
        p = Picture.find pid
        p.twitter_id = t.id
        p.save!
      end unless picture_ids.blank?
      render_success_json 'Twitter create success.', :created, { twitter: t }
    else
      render_fail_json 'Twitter create fail.', :unprocessable_entity, { errors: t.errors }
    end
  end

  def show
    render_success_json 'One twitter.', :ok, { twitter: @twitter }
  end

  def update
    if @current_user.id != @twitter.user_id
      render_fail_json 'Not current user.', :forbidden
    else
      if @twitter.update(twitter_params)
        render_success_json 'Twitter update success.', :ok, { twitter: @twitter }
      else
        render_fail_json 'Twitter update fail.', :unprocessable_entity, { errors: @twitter.errors }
      end
    end
  end

  def destroy
    @twitter.destroy
    render_success_json 'Twitter destroy success.', :ok
  end

  private

  def set_twitter
    @twitter = Twitter.find(params[id])
  end

  def twitter_params
    params.require(:twitter).permit(
      :user_id,
      :content,
      :source,
      :url,
      :parent_id,
      :anonymous,
      :longitude,
      :latitude,
      :to_user_id
    )
  end
end