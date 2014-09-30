class Book < ActiveRecord::Base
	scope :finished, -> { where.not(finished_on: nil) }
	scope :recent, -> { where('finished_on > ?', 2.days.ago) }
	scope :search, -> (keyword){where('keyword LIKE ?', "%#{keyword.downcase}%") if keyword.present? }

	before_save :set_keywords
	belongs_to :genre
	def finished?
		finished_on.present?
	end

	protected

	def set_keywords
		self.keyword = [title, author, description].map(&:downcase).join('')
	end


end
