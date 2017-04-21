class Album < ApplicationRecord
  validates :name, presence: true
  validates :band_id, presence: true, uniqueness: true
  validates :recording_method, inclusion: { in: %w(live studio) }

  belongs_to :band,
    primary_key: :id,
    foreign_key: :band_id,
    class_name: 'Band'

  has_many :tracks,
    dependent: :destroy,
    primary_key: :id,
    foreign_key: :album_id,
    class_name: 'Track'
end
