class Station < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates_presence_of :name
  validates_presence_of :dock_count
  validates_presence_of :city
  validates_presence_of :installation_date

  has_many :start_trips, class_name: 'Trip', foreign_key: 'start_station_id', dependent: :destroy
  has_many :end_trips, class_name: 'Trip', foreign_key: 'end_station_id', dependent: :destroy

  def to_param
    slug
  end

  def self.average_bikes
    average(:dock_count)
  end

  def self.most_bikes
    maximum(:dock_count)
  end

  def self.most_bikes_station
    find_by(dock_count: most_bikes)
  end

  def self.fewest_bikes
    minimum(:dock_count)
  end

  def self.fewest_bikes_station
    find_by(dock_count: fewest_bikes)
  end

  def self.newest
    find_by(installation_date: maximum(:installation_date))
  end

  def self.oldest
    find_by(installation_date: minimum(:installation_date))
  end

  def total_ride_starts
    start_trips.count
  end

  def total_ride_ends
    end_trips.count
  end

  def most_frequent_destination
    start_trips.select('trips.end_station_id, count (trips.end_station_id) AS total')
    .group('trips.end_station_id')
    .order('total')
  end

  def most_frequent_start
    end_trips.select('trips.start_station_id, count (trips.start_station_id) AS total')
    .group('trips.start_station_id')
    .order('total')
  end

  def date_with_most_trips
    start_trips.select('trips.start_date, count(trips.start_station_id) AS total')
    .group('trips.start_date')
    .order('total')
  end

  def zip_code_with_most_trips
    start_trips.select('trips.zip_code, count(trips.start_station_id) AS total')
    .group('trips.zip_code')
    .order('total')
  end

  def bike_with_most_trips
    start_trips.select('trips.bike_id, count(trips.start_station_id) AS total')
    .group('trips.bike_id')
    .order('total')
  end

  def self.most_starting_rides
    joins(:start_trips).group("stations.id").order('COUNT(stations.id) DESC').first
  end

  def self.most_ending_rides
    joins(:end_trips).group("stations.id").order('COUNT(stations.id) DESC').first
  end
end
