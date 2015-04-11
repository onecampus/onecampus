##
# Author:: FuSheng Yang (mailto:sysuyangkang@gmail.com)
# Copyright:: Copyright (c) 2015 thecampus.cc
# License:: Distributes under the same terms as Ruby
# Api of pictures
class Api::V1::PicturesController < ApplicationController
  def picture_uploader
    image = PictureUploader.new
    image.store!(params[:picture])
    picture = Picture.new(
      url: image.url,
      user_id: @current_user.id,
      status: 1
    )
    if picture.save
      data = {
        state: 'success',
        url: image.url,
        title: image.filename,
        picture_id: picture.id
      }
      render_success_json('Picture create success.', :created, data)
    else
      render_fail_json 'Picture create fail.', :unprocessable_entity, { errors: picture.errors }
    end
  end
end