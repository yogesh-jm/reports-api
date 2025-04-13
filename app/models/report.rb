class Report < ApplicationRecord
  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :reporter, presence: true
end
