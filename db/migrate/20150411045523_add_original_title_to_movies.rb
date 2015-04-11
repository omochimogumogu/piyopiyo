class AddOriginalTitleToMovies < ActiveRecord::Migration
  def change
  	add_column :movies, :original_title, :string ,after: :title
  end
end
