class ChargesController < ApplicationController

  before_filter :authenticate_user!

def create
  customer = Stripe::Customer.create(
    email: current_user.email,
    card: params[:stripeToken]
  )

  charge = Stripe::Charge.create(
     customer: customer.id, # Note -- this is NOT the user_id in your app
     amount: 299,
     description: "BigMoney Membership - #{current_user.email}",
     currency: 'usd'
   )

  @user = current_user
  @user.premium_user = true
  @user.save

  flash[:notice] = "Purchase completed, enjoy!"
  redirect_to root_path

  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_charge_path

end

def new
   @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     description: "Pro Membership - #{current_user.email}",
     amount: 299
   }
 end

 def downgrade
   @pages = Page.all
 end

 def execute_downgrade
   @user = current_user
   @user.premium_user = false;
   @user.save
   @allPages = Page.all
   @allPages.each do |page|
     if page.user_id == current_user.id
       page.private = false
       page.save
     end
   end

   flash[:notice] = "Downgraded to Free Account"

   redirect_to edit_user_registration_path
 end


end
