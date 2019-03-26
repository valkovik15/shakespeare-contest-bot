class QuizController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    uri = URI("https://shakespeare-contest.rubyroidlabs.com/quiz")
    level_ = params['level'].to_i
    task_id_ = params['id']
    question_ = params['question']
    case level_
    when 1
      answer = $level1.get(question_)
      if answer.nil?
        answer = $level1.get(question_ + '.')
        if answer.nil?
          answer = $level1.get(question_ + ',')
        end
        if answer.nil?
          answer = $level1.get(question_ + ';')
        end
        if answer.nil?
          answer = $level1.get(question_ + ':')
        end
        if answer.nil?
          answer = $level1.get(question_ + '!')
        end
        if answer.nil?
          answer = $level1.get(question_ + '?')
        end
        if answer.nil?
          last_chance = rem_punct question_
          answer = $level1.get(last_chance)
          if answer.nil?
            answer = $levelq.get(last_chance.strip)
          end
        end
      end
    when 2
      last_chance = rem_punct question_
      answer = $level2.get(last_chance)
      if answer.nil?
        answer = $level2.get(last_chance.strip)
      end
    end
    parameters = {
        answer: answer,
        token: 'd77f89c45e2089bf3a721acf0c9edfd2',
        task_id: task_id_
    }

    resp = Net::HTTP.post_form(uri, parameters)
    str=question_+' '+resp.body
    Input.new('task_id' => task_id_, 'question' => str, 'level' => level_).save
    render plain: answer
  end

  def rem_punct str
    str.gsub(/[^A-Za-z0-9\s]/i, '')
  end
end
