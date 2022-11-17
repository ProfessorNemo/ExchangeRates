# frozen_string_literal: true

require 'faraday'
require 'xml/to/json'
require 'active_support'

module ExchangeRates
  class Parser < ::ApplicationService
    URL = 'http://www.cbr.ru/scripts/XML_daily.asp'

    def initialize(exchange_rate, force)
      @exchange_rate = exchange_rate
      @force = force

      super
    end

    def call
      return if !@force && @exchange_rate.rate_at > Time.zone.now

      response_body = extract_content_by_url
      raise 'Не удалось получить данные с сервера' unless response_body

      rate_value = extract_rate_value(response_body)

      return if rate_value.zero?

      ExchangeRate.where(id: @exchange_rate).update_all(rate_value: rate_value)
      ExchangeRates::Dispatch.call(@exchange_rate.reload)
    end

    private

    def extract_content_by_url
      connection = Faraday.new do |faraday|
        faraday.request :multipart
        faraday.request :url_encoded
        faraday.adapter :net_http
      end

      response ||= connection.get(URL)

      xml = Nokogiri::XML response.body

      JSON.parse(JSON.pretty_generate(xml.root))['children']
    rescue StandardError
      false
    end

    def extract_rate_value(response)
      children(response, response.map.with_index do |_val, index|
                           children(response, index, 1) == 'USD' ? index : nil
                         end.compact.first, 4)
        .tr(',', '.').to_f
    end

    def children(response, index_name, index_rate)
      response[index_name]['children'][index_rate]['children'].first['content']
    end
  end
end
