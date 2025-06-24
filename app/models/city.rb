class City < ApplicationRecord
    has_many :dog
    has_many :dogsitter
end
