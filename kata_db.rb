require 'securerandom'

MAX_RESAMPLE = 5

class KataDB
  def initialize(word_vectors)
    @word_vectors = word_vectors
    @answer_keys = {}
  end

  def random_question
    question_id = random_question_id
    word = random_word
    scrambled_word = scramble_word(word)

    @answer_keys[question_id] = word

    question = {
      question_id: question_id,
      scrambled_word: scrambled_word,
    }
    question
  end

  def correct_answer?(question_id, guess)
    result = @answer_keys[question_id] == guess
    if result
      @answer_keys.delete(question_id)
    end
    result
  end

  def true_answer(question_id)
    answer = @answer_keys[question_id]
    @answer_keys.delete(question_id)
    answer
  end

  private

  def random_question_id
    SecureRandom.uuid
  end

  def random_word
    @word_vectors.sample
  end

  def scramble_word(word)
    sampled = word
    resampled_ctr = 0
    while sampled == word && resampled_ctr < MAX_RESAMPLE
      resampled_ctr = resampled_ctr + 1
      sampled = word.chars.to_a.shuffle.join
    end
    sampled
  end
end