class ContactFormsController < ApplicationController
  def new
    @contact_form = ContactForm.new
  end

  def create
    @contact_form = ContactForm.new(contact_form_params)

    if @contact_form.save
      # Якщо форма збережена, рендеримо сторінку create
      flash[:notice]
      render :create
    else
      render :new
    end
  end

  private

  def contact_form_params
    params.require(:contact_form).permit(:name, :email, :message)
  end
end




