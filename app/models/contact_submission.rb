class ContactSubmission < ApplicationRecord
  validates :name, no_html: true
  validates :email, no_html: true
  validates :message, presence: true, no_html: true
end
