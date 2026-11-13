class NominationsController < ApplicationController
  rate_limit to: 5, within: 1.minute, only: :create, with: -> {
    redirect_to root_path(anchor: "nominate"), alert: "Easy, tiger. Try again in a minute."
  }

  def create
    @nomination = Nomination.new(nomination_params)

    if @nomination.save
      redirect_to root_path(anchor: "nominate"), notice: "Got it, thanks. Sorry, but someone had to say it."
    else
      render "pages/home", status: :unprocessable_entity
    end
  end

  private
    def nomination_params
      params.expect(nomination: [ :idea, :message ])
    end
end
