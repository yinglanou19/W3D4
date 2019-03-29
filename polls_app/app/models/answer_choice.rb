# == Schema Information
#
# Table name: answer_choices
#
#  id          :bigint(8)        not null, primary key
#  question_id :integer          not null
#  option      :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class AnswerChoice < ApplicationRecord

  validates :question_id, :option, presence:true
  
    belongs_to :question,
      class_name: :Question,
      primary_key: :id,
      foreign_key: :question_id

    has_many :responses,
      class_name: :Response,
      primary_key: :id,
      foreign_key: :option_id


end
