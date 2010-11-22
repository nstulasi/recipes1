class Recipe < ActiveRecord::Base

  belongs_to :user
  validates_presence_of :name, :ingredients, :directions
  acts_as_rateable

  acts_as_taggable

end