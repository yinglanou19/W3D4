# == Schema Information
#
# Table name: responses
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer          not null
#  option_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Response < ApplicationRecord

  validates :user_id, :option_id,presence:true
  # validate(:pick_one_only)

  # def pick_one_only
  #   res = self.answer_choice.question.answer_choices
  #   list_of_user_id = []
  #   res.each do |r|
  #     r.responses.each do |one_response|
  #       list_of_user_id << one_response.user_id
  #     end
  #   end

  #   if list_of_user_id.include?(self.user_id)
  #     error[:user_id] << "You can only pick one choice per question"
  #   end
  # end

    belongs_to :answer_choice,
      class_name: :AnswerChoice,
      primary_key: :id,
      foreign_key: :option_id

    belongs_to :respondent,
      class_name: :User, 
      primary_key: :id,
      foreign_key: :user_id

    has_one :question,
      through: :answer_choice,
      source: :question

    def sibling_responses
      self.question.responses.where.not(:id,self.id)
    end

    def respondent_already_answered?
      self.sibling_responses.each |one_response|
        return true if one_response.user_id == self.user_id
      end
      return false
    end


end
