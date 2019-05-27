require "./kata_db.rb"
require "./game_strings.rb"
require "./word_vector_generator.rb"

MAX_TRIAL = 5

if $PROGRAM_NAME == __FILE__
  method = :default
  if ARGV[0] == "dictionary"
    method = :dictionary
  end
  ARGV.clear
  word_vec_generator = WordVectorGenerator.new(method)
  word_vec = word_vec_generator.generate

  kata_db = KataDB.new(word_vec)
  game_strings = GameStrings.new

  score = 0;
  correct = false;

  while true
    q = kata_db.random_question
    puts "#{game_strings.word_guess} #{q[:scrambled_word]}"
    correct = false
    trial_ctr = 0
    while !correct
      print game_strings.answer
      input_answer = gets.chop
      trial_ctr = trial_ctr + 1

      if kata_db.correct_answer?(q[:question_id], input_answer)
        score = score + 1
        correct = true
        puts "#{game_strings.correct_answer} #{score}"
      elsif trial_ctr < MAX_TRIAL
        puts game_strings.wrong_answer
      else
        correct = true
        puts "#{game_strings.too_many_wrong_answer} #{kata_db.true_answer(q[:question_id])}"
      end
    end
  end
end
