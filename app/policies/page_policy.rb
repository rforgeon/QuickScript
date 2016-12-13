class PagePolicy < ApplicationPolicy

  class Scope
     attr_reader :user, :scope

     def initialize(user, scope)
       @user = user
       @scope = scope
     end

     def resolve
       pages = []
       if user.premium_user == 'true'
         all_pages = scope.all
         collaborators = Collaborator.all
         all_pages.each do |page|
           if page.private == false || page.user_id == user.id || collaborators.include?(page.id)
             pages << page # if the user is premium, only show them public pages, or that private pages they created, or private pages they are a collaborator on
           end
         end
       else # this is the lowly standard user
         all_pages = scope.all
         pages = []
         all_pages.each do |page|
           if page.private == false || page.collaborators.include?(user)
             pages << page # only show standard users public pages and private pages they are a collaborator on
           end
         end
       end
       pages # return the pages array we've built up
     end
   end

end
