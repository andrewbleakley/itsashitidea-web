class PagesController < ApplicationController
  def home
    @nomination = Nomination.new
  end
end
