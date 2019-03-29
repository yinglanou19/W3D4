# == Schema Information
#
# Table name: questions
#
#  id         :bigint(8)        not null, primary key
#  poll_id    :integer          not null
#  body       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Question < ApplicationRecord
  
  validates :poll_id, :body,presence:true
  
  belongs_to :poll,
    class_name: :Poll,
    primary_key: :id,
    foreign_key: :poll_id
    
  has_many :answer_choices,
    class_name: :AnswerChoice,
    primary_key: :id,
    foreign_key: :question_id

  has_many :responses
    through: :answer_choices,
    source: :responses


  
end
