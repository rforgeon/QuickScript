class CollaboratorsController < ApplicationController
  def create

    @page = Page.find(params[:page_id])
    @collaborator = Collaborator.new(collaborator_params)
    @collaborator.page_id = @page.id
    @allCollabs = Collaborator.all
    #check if collaborator is already on page
    @allCollabs.each do |c|
      if @collaborator.email == c.email
        flash[:alert] ="#{@collaborator.email} is already a collaborator on this page."
        redirect_to edit_page_path(@page.id) and return
      end
    end

    #add user in reference to email
    @users = User.all
    @user_emails = @users.map{|u|u.email}
      if @user_emails.any?{@collaborator.email}
        @users.each do |u|
          if u.email == @collaborator.email
            @page.user_id = u.id
          end
        end
      else
        flash[:alert] ="Please add the email of a current registered user."
        redirect_to edit_page_path(@page.id) and return
      end



    if @collaborator.save
      redirect_to edit_page_path(@page.id), notice: "collaborator was saved successfully."
    else
      flash.now[:alert] = "Error creating collaborator. Please try again."
      render :new
    end
  end

  def new
    @collaborator = Collaborator.new
  end

  private

  def collaborator_params
    params.require(:collaborator).permit(:email,:page_id)
  end


end
