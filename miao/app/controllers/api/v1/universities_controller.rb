##
# Author:: FuSheng Yang (mailto:sysuyangkang@gmail.com)
# Copyright:: Copyright (c) 2015 thecampus.cc
# License:: Distributes under the same terms as Ruby
# Api of users
class Api::V1::UniversitiesController < ApplicationController
  skip_before_action :authenticate_request, only: [:index]

  def index
    @universities = University.all
    render_success_json 'Universities all.', :ok, { universities: @universities }
  end
end