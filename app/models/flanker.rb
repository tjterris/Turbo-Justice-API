class Flanker < ActiveRecord::Base
  # model associations
  belongs_to :user

  # validations
  validates :correct_guesses, :incorrect_guesses, :user_id, :clicktimes, presence: true

  # allows clicktimes to be stored as an integer array
  serialize :clicktimes

  # methods
  def add_flanker_guesses_to_user!
    x = self.user.total_correct_flanker_guesses
    y = self.user.total_incorrect_flanker_guesses

    self.user.update(total_correct_flanker_guesses: x + self.correct_guesses,
                     total_incorrect_flanker_guesses: y + self.incorrect_guesses)
  end

  def update_flanker_games_played!
    i = self.user
    i.update(flanker_games_played: i.flanker_games_played + 1)
  end

  def save_flanker_data!(params)
    self.add_flanker_guesses_to_user!
    self.update_flanker_games_played!
    self.calculate_and_save_clicktimes!(params)
  end

  # Note: the first clicktime records the time it took the user to record his first answer after pressing start.

  def calculate_and_save_clicktimes!(params)
    clicktimes = params[:clicktimes].split(",").map(&:to_i)
    self.update(clicktimes: find_difference(clicktimes))
  end

  private

  def find_difference(cts_array)
     cts_array.each_with_index.map {|x,i| cts_array[i+1] - x unless i == cts_array.length - 1 }.compact
  end

end
