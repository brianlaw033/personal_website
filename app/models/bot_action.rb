class BotAction < ApplicationRecord
  include Rails.application.routes.url_helpers

  validates_presence_of :user_input, message: "can't be empty"
  validates_length_of :user_input, minimum: 2, maximum: 200, message: "accepts only 2 - 200 characters"
  before_save :strip_user_input

  TRAINING_DATA = YAML.load_file('config/chatbot/training.yml')
 #puts "nnTRAINING DATA = #{TRAINING_DATA.inspect}nn"

  def process_input(user_input)
    user_input_tokens = clean_user_input(user_input)
    #puts "nnCommon Word = #{common_word.inspect}nn"
    send("test_enquiry", user_input_tokens)
  end

  def classification_failed_enquiry(*args)
    self.update_attribute(:bot_response, error_response)
    return false
  end

  def nbayes_classification(user_input_tokens)
    nbayes = NBayes::Base.new(binarized: true)             #
    TRAINING_DATA.each do |key, value|   #getting the inner hash, ex: 'new_laptop_enquiry' hash
      category = key                                       #assigning key as category (class), ex: 'new_laptop_enquiry'
      #puts "nnCategory: #{category.inspect}nn"
      value.each do |str|
        #puts "nnString: #{str.inspect}nn"
        nbayes.train(str.split(' '), category)           #Training the nbayes object, with each string under 'new_laptop_enquiry' class
      end
    end

    nbayes.assume_uniform = true                           #

    result = nbayes.classify(user_input_tokens)            #classifying the input form user
    nbayes.dump('config/rembot/dump.yml')                 #dump of trained data, for us to observe how the classification is done

    result.each do |k, v|
      puts "n#{(v * 100)} => #{k}n"                      #display of classified log probabilities for each category
    end
    result.max_class
  end
  #
  # def process_input(user_input)
  #   user_input_tokens = clean_user_input(user_input)
  #   common_array = user_input_tokens & FINAL_ARRAY  #Intersection of both
  #   common_word = common_array.present? ? common_array.first.singularize : "classification_failed"
  #   #puts "nnCommon Word = #{common_word.inspect}nn"
  #   send("#{common_word}_enquiry", user_input_tokens)
  # end
  #
  # def classification_failed_enquiry(*args)
  #   self.update_attribute(:bot_response, error_response)
  #   return false
  # end
  #
  # def nbayes_classification(user_input_tokens, method_name)
  #   nbayes = NBayes::Base.new(binarized: true)             #
  #   TRAINING_DATA[method_name.to_s].each do |key, value|   #getting the inner hash, ex: 'new_laptop_enquiry' hash
  #     category = key                                       #assigning key as category (class), ex: 'new_laptop_enquiry'
  #     #puts "nnCategory: #{category.inspect}nn"
  #     value.each do |str|
  #       #puts "nnString: #{str.inspect}nn"
  #       nbayes.train(str.split(' '), category)           #Training the nbayes object, with each string under 'new_laptop_enquiry' class
  #     end
  #   end
  #
  #   nbayes.assume_uniform = true                           #
  #
  #   result = nbayes.classify(user_input_tokens)            #classifying the input form user
  #   #nbayes.dump('config/rembot/dump.yml')                 #dump of trained data, for us to observe how the classification is done
  #
  #   result.each do |k, v|
  #     puts "n#{(v * 100)} => #{k}n"                      #display of classified log probabilities for each category
  #   end
  #
  #   result.max_class                                       #final classified category, ex: 'new_laptop_enquiry'
  # end

  #classifications related to laptops
  def test_enquiry(user_input_tokens)
    send(nbayes_classification(user_input_tokens))
  end

  # def resume_enquiry(user_input_tokens)
  #   send(nbayes_classification(user_input_tokens, __method__))
  # end
  #
  # def unknown_enquiry(*args)
  #   self.update_attribute(:bot_response, error_response)
  #   return false
  # end

  def hi_enquiry(*args)
    self.update_attribute(:bot_response, hi_response)
    return false
  end

  def show_resume_enquiry(*args)
    self.update_attribute(:bot_response, "show")
    return false
  end

  def download_resume_enquiry(*args)
    self.update_attribute(:bot_response, "download")
    return false
  end

  # def yourself_enquiry(user_input_tokens)
  #   send(nbayes_classification(user_input_tokens, __method__))
  # end


  def self_intro_enquiry(*args)
    self.update_attribute(:bot_response, "I'm Brian.")
    return false
  end

  def greeting_enquiry(*args)
    self.update_attribute(:bot_response, greeting_response)
    return false
  end

  def contact_enquiry(*args)
    self.update_attribute(:bot_response, 'Here you are:) brian9328hk@gmail.com I prefer using email :)')
    return false
  end

  private

  def hi_response
    ["Hi:) Nice to meet you.",
     "How can I help you?",
     "Hey there!"].sample
  end

  def greeting_response
    ["Good! Finally there is someone talk to me :)",
     "What do you expect a bot's life will be :O)",
     "Awesome!!! I spend the whole day here studying English!"].sample
  end

#Random error message from array
  def error_response
    ["I'm Sorry, I don't understand. Please try again",
     "Oh oh! Something went wrong. Please try again",
     "Um... Sorry, I don't understand. Did you input correct words?"].sample
  end

  def strip_user_input
    self.user_input = self.user_input.squish
  end

  def clean_user_input(user_input)
    rm_spl_chars = user_input.downcase.gsub(/[^a-zA-Z0-9-#s]/, ' ')
    rm_spl_chars.split(' ')
  end
end
