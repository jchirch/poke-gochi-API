class Pokemon < ApplicationRecord
    belongs_to :trainer
    
    validates :name, presence: true
    validates :description, presence: true
    validates :gif_url, presence: true
    validates :cry_url, presence: true
    validates :small_img, presence: true
    validates :level, presence: true
    validates :xp, presence: true
    validates :energy, presence: true
    validates :max_energy, presence: true
    validates :happiness, presence: true
    validates :trainer_id, presence: true
end
