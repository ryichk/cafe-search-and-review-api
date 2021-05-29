class Place < ApplicationRecord
  geocoded_by :name
  after_validation :geocode

  has_many :reviews
  validates :address, uniqueness: true
  has_many :like_places, dependent: :destroy
  has_many :good_users, through: :like_places, source: :user

  #placeをいいねする
  def good(user)
    like_places.create(user_id: user.id)
  end

  #placeのいいねを解除する
  def ungood(user)
    like_places.find_by(user_id: user.id).destroy
  end

  #現在のユーザーがいいねしていたらtrueを返す
  def good?(user)
    good_users.include?(user)
  end

  def review_average
    average = self.reviews.average(:rank).round(1)
    if average == 0
      average = 0
    elsif average > 0 && average <= 0.7
      average = 0.5
    elsif average > 0.7 && average <= 1.4
      average = 1
    elsif average > 1.4 && average <= 1.7
      average = 1.5
    elsif average > 1.7 && average <= 2.4
      average = 2
    elsif average > 2.4 && average <= 2.7
      average = 2.5
    elsif average > 2.7 && average <= 3.4
      average = 3
    elsif average > 3.4 && average <= 3.7
      average = 3.5
    elsif average > 3.7 && average <= 4.4
      average = 4
    elsif average > 4.4 && average <= 4.7
      average = 4.5
    elsif average > 4.7 && average <= 5
      average = 5
    end
  end
  def review_average_menu
    average = self.reviews.average(:menu)
    if average == 0 || average == nil
      average = 0
    elsif average > 0 && average <= 1.4
      average = 1
    elsif average > 1.4 && average <= 2.4
      average = 2
    elsif average > 2.4 && average <= 3.4
      average = 3
    elsif average > 3.4 && average <= 4.4
      average = 4
    elsif average > 4.4 && average <= 5
      average = 5
    end
  end
  def review_average_cost
    average = self.reviews.average(:cost)
    if average == 0 || average == nil
      average = 0
    elsif average > 0 && average <= 1.4
      average = 1
    elsif average > 1.4 && average <= 2.4
      average = 2
    elsif average > 2.4 && average <= 3.4
      average = 3
    elsif average > 3.4 && average <= 4.4
      average = 4
    elsif average > 4.4 && average <= 5
      average = 5
    end
  end
  def review_average_coffee
    average = self.reviews.average(:coffee)
    if average == 0 || average == nil
      average = 0
    elsif average > 0 && average <= 1.4
      average = 1
    elsif average > 1.4 && average <= 2.4
      average = 2
    elsif average > 2.4 && average <= 3.4
      average = 3
    elsif average > 3.4 && average <= 4.4
      average = 4
    elsif average > 4.4 && average <= 5
      average = 5
    end
  end
  def review_average_smoke
    average = self.reviews.average(:smoke)
    if average == 0 || average == nil
      average = 0
    elsif average > 0 && average <= 1.4
      average = 1
    elsif average > 1.4 && average <= 2.4
      average = 2
    elsif average > 2.4 && average <= 3.0
      average = 3
    end
  end
  def review_average_wifi
    average = self.reviews.average(:wifi)
    if average == 0 || average == nil
      average = 0
    elsif average > 0 && average <= 1.4
      average = 1
    elsif average > 1.4 && average <= 2.4
      average = 2
    elsif average > 2.4 && average <= 3.4
      average = 3
    elsif average > 3.4 && average <= 4.4
      average = 4
    elsif average > 4.4 && average <= 5
      average = 5
    end
  end
  def review_average_elec
    average = self.reviews.average(:elec)
    if average == 0 || average == nil
      average = 0
    elsif average > 0 && average <= 1.4
      average = 1
    elsif average > 1.4 && average <= 2.0
      average = 2
    end
  end
end
