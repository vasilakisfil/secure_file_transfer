
class CreateSecureFiles < ActiveRecord::Migration
  def change
    create_table :secure_files do |t|
      t.string :file
      t.string :name
      t.string :description
      t.string :shared_to
      t.boolean :seen
      t.string :shared_by
      t.belongs_to :user

      t.timestamps
    end
  end
end

