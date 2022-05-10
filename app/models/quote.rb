class Quote < ApplicationRecord
  validates :name, presence: true

  scope :ordered, -> { order(id: :desc) }

  # after_create_commit -> { 
  #     broadcast_prepend_to "quotes", partial: "quotes/quote", locals: { quote: self }, target: "quotes" 
  # }

  # Using default
  # after_create_commit -> { broadcast_prepend_to "quotes" }
  # after_update_commit -> { broadcast_replace_to "quotes" }
  # after_destroy_commit -> { broadcast_remove_to "quotes" }

  # Use background job
  # after_create_commit -> { broadcast_prepend_later_to "quotes" }
  # after_update_commit -> { broadcast_replace_later_to "quotes" }
  
  
  #Note: The broadcast_remove_later_to method does not exist because as the quote gets 
  # deleted from the database, it would be impossible for a background job to retrieve 
  # this quote in the database later to perform the job.
  
  # after_destroy_commit -> { broadcast_remove_to "quotes" }

   # Those three callbacks are equivalent to the following single line
   broadcasts_to ->(quote) { "quotes" }, inserts_by: :prepend
end
