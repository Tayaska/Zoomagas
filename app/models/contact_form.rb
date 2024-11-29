class ContactForm < ApplicationRecord
  # Валідації для полів форми
  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :message, presence: true, length: { minimum: 10 }

  # Інші логіки, якщо потрібно, можуть бути додані тут
end

