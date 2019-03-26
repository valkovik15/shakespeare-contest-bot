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
    when 3
      strings = question_.split('\n')
      strings[0] = rem_punct strings[0]
      strings[1] = rem_punct strings[1]
      answer1 = $level2.get(strings[0])
      if answer1.nil?
        answer1 = $level2.get(strings[0].strip)
      end
      answer2 = $level2.get(strings[1])
      if answer2.nil?
        answer2 = $level2.get(strings[1].strip)
      end
      answer = answer1 + ',' + answer2
    when 3
      strings = question_.split('\n')
      strings[0] = rem_punct strings[0]
      strings[1] = rem_punct strings[1]
      strings[2] = rem_punct strings[2]
      answer1 = $level2.get(strings[0])
      if answer1.nil?
        answer1 = $level2.get(strings[0].strip)
      end
      answer2 = $level2.get(strings[1])
      if answer2.nil?
        answer2 = $level2.get(strings[1].strip)
      end
      answer3 = $level2.get(strings[2])
      if answer3.nil?
        answer3 = $level2.get(strings[2].strip)
      end
      answer = answer1 + ',' + answer2 + ',' + answer3
    end
    parameters = {
        answer: answer,
        token: 'd77f89c45e2089bf3a721acf0c9edfd2',
        task_id: task_id_
    }

    resp = Net::HTTP.post_form(uri, parameters)
    str = question_ + ' ' + resp.body
    Input.new('task_id' => task_id_, 'question' => str, 'level' => level_).save
    render plain: answer
  end

  def rem_punct str
    str.gsub(/[^A-Za-z0-9\s]/i, '')
  end
end
