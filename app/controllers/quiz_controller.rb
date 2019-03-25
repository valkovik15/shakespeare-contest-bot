class QuizController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    uri = URI("https://shakespeare-contest.rubyroidlabs.com/quiz")
    level_ = params['level'].to_i
    task_id_ = params['id']
    question_ = params['question']
    case level_
    when 1
      answer = $level1[question_]
      if answer.nil?
        answer = $level1[question_ + '.']
        if answer.nil?
          answer = $level1[question_ + ',']
        end
        if answer.nil?
          answer = $level1[question_ + ';']
        end
        if answer.nil?
          answer = $level1[question_ + ';']
        end
      end
    end
    parameters = {
        answer: answer,
        token: 'd77f89c45e2089bf3a721acf0c9edfd2',
        task_id: task_id_
    }

    Net::HTTP.post_form(uri, parameters)
    Input.new('task_id' => task_id_, 'question' => question_, 'level' => level_).save
    render plain: parameters
  end
end
