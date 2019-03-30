class QuizController < ApplicationController
  skip_before_action :verify_authenticity_token

  def level_1 question_
    answer = $level1.get(question_)
    if answer.nil?
      answer = $level1.get(question_ + '.')
    else
      return answer
    end
    if answer.nil?
      answer = $level1.get(question_ + '.')
    else
      return answer
    end
    if answer.nil?
      answer = $level1.get(question_ + '!')
    else
      return answer
    end
    if answer.nil?
      answer = $level1.get(question_ + '?')
    else
      return answer
    end
    if answer.nil?
      answer = $level1.get(question_ + ';')
    else
      return answer
    end
    if answer.nil?
      answer = $level1.get(question_ + ':')
    else
      return answer
    end
    if answer.nil?
      last_chance = rem_punct question_
      answer = $level1.get(last_chance)
    else
      return answer
    end
    $level1.get(last_chance.strip)
  end

  def level_5(quest)
    quest = rem_punct quest
    words = quest.split
    words.each_with_index do |word, key|
      words[key] = 'WORD'
      ans = $level2.get words.join(' ')
      if ans.nil?
        words[key] = word
      else
        return ans + ',' + word
      end
    end
    ''
  end

  def level_8 (question_)
    str = rem_punct question_.strip
    log=""
    words_sorted = str.chars.sort(&:casecmp)
    words_sorted.each_with_index do |word, index|
      words_sorted[index] = '.'
      _curs_, answ=$level3.scan(0, :match=>words_sorted.join.to_s)
      log+=(answ.inspect+' ')
      return answ[0]+log unless answ.nil?
      words_sorted[index] = word
    end
    ''
  end

  def index
    uri = URI("https://shakespeare-contest.rubyroidlabs.com/quiz")
    level_ = params['level'].to_i
    task_id_ = params['id']
    question_ = params['question']
    case level_
    when 1
      answer = level_1 question_
    when 2
      last_chance = rem_punct question_
      answer = $level2.get(last_chance)
      if answer.nil?
        answer = $level2.get(last_chance.strip)
      end
    when 3
      strings = question_.split("\n")
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
    when 4
      strings = question_.split("\n")
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
    when 5
      answer = level_5 question_

    when 6, 7
      str = rem_punct question_.strip
      str_sorted = str.chars.sort(&:casecmp).join
      answer = $level3.get str_sorted
    when 8
      answer = level_8 question_
      

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
