class PagesController < ApplicationController


  def index
     @pages = Page.all
   end

   def show
     @page = Page.find(params[:id])
   end

   def new
     @page = Page.new
   end

   def create
     @page = Page.new(page_params)

     if @page.save
       redirect_to @page, notice: "Page was saved successfully."
     else
       flash.now[:alert] = "Error creating page. Please try again."
       render :new
     end
   end

   def edit
     @page = Page.find(params[:id])
   end

   def update
     @page = Page.find(params[:id])

     @page.assign_attributes(page_params)

     if @page.save
        flash[:notice] = "Page was updated."
       redirect_to @page
     else
       flash.now[:alert] = "Error saving page. Please try again."
       render :edit
     end
   end

   def destroy
    @page = Page.find(params[:id])

    if @page.destroy
      flash[:notice] = "\"#{@page.title}\" was deleted successfully."
      redirect_to action: :index
    else
      flash.now[:alert] = "There was an error deleting the page."
      render :show
    end
  end

  private

  def page_params
    params.require(:page).permit(:title, :body, :private)
  end

end
