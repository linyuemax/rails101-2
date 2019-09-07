class Group < ApplicationRecord
  belongs_to :user
  has_many :posts
  validates :title, presence: true

  has_many :group_relationships
  #取得群組內所屬使用者，經由group_relationships，來源欄位為user
  has_many :members, through: :group_relationships, source: :user
end
