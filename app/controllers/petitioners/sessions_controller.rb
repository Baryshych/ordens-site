class Petitioners::SessionsController < Devise::SessionsController
  def new
    if petitioner_signed_in?
      redirect_to petitions_path
      return
    end
    @petitioner = Petitioner.new
    render 'petitioners/sign_in'
  end
end
