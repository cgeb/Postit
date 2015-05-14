module Sluggable
  extend ActiveSupport::Concern

  included do
    before_save :generate_slug
    class_attribute :slug_column
  end

  def obj_lookup(str)
    self.class.find_by slug: str
  end

  def to_slug
    str = self.send(self.class.slug_column.to_sym).downcase.gsub(/[^0-9a-zA-Z]/, "-")
    str = str.gsub(/-+/, "-")
  end

  def generate_slug
    the_slug = to_slug
    obj = obj_lookup(to_slug)
    count = 2
    if obj && obj != self
      the_slug = the_slug + "-" + count.to_s
      obj = obj_lookup(the_slug)
    end
    while obj && obj != self
      count += 1
      the_slug[-1] = count.to_s
      obj = obj_lookup(the_slug)
    end
    self.slug = the_slug
  end

  def to_param
    self.slug
  end

  module ClassMethods
    def sluggable_column(col_name)
      self.slug_column = col_name
    end
  end
end