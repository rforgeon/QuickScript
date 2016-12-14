class PagePolicy < ApplicationPolicy

  class Scope
     attr_reader :user, :scope

     def initialize(user, scope)
       @user = user
       @scope = scope
     end

     def resolve
       pages = []
         all_pages = scope.all
         collaborators = Collaborator.all
         all_pages.each do |page|
           if page.private == false || page.user_id == user.id
             pages << page # show public pages
           end
           collaborators.each do |collab|
             if (collab.page_id == (page.id) ) && collab.email == user.email
               pages << page # show private pages they created, or private pages they are a collaborator on
             end
           end
         end
       pages # return the pages array we've built up
     end
   end

end
