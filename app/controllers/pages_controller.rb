class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @profession = User.where.not(profession: nil)
  end
end
