class Mpost < ActiveRecord::Base
  self.per_page = 10
  attr_accessible :content
  belongs_to :user
  default_scope :order =>'mposts.created_at DESC'
  validates :content, :presence => true, 
    :length => {:maximum => 140}
  validates :user_id, :presence => true
  scope :by_user_id, lambda{|id| where(user_id: id) unless id.nil? }
end
