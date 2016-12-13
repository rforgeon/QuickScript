class AddPageIdToCollaborators < ActiveRecord::Migration
  def change
    add_column :collaborators, :page_id, :integer
  end
end
