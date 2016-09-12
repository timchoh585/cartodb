# encoding utf-8

require_relative './carto_json_serializer'

module Carto
  class Legend < ActiveRecord::Base
    VALID_CATEGORIES = %w(html category bubble choropleth custom).freeze

    serialize :properties, ::Carto::CartoJsonSerializer

    validates :properties, carto_json_symbolizer: true
    validates :title, :prehtml, :posthtml, :layer_id, presence: true
    validates :category, inclusion: { in: VALID_CATEGORIES }

    after_initialize :ensure_properties

    private

    def ensure_properties
      self.properties ||= Hash.new
    end
  end
end
