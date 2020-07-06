require 'hanami/interactor'
require 'nokogiri'

class Scrape
  include Hanami::Interactor

  WEBSITE_URL = 'https://msdh.ms.gov/msdhsite/_static/14,0,420.html'
  DATE_ID     = '#assetNow_pageSubtitle'
  TABLE_ID    = '#msdhTotalCovid-19Cases'

  attr_reader :raw_html

  expose :county_updates

  def initialize(raw_html)
    @raw_html = raw_html
  end

  def call
    @county_updates = rows_without_ltc_data.map do |row|
      CountyUpdateRepository.new.create_from_row(row: row, date: date)
    end
  end

  def date
    @date ||= Date.parse(Nokogiri::HTML(raw_html).css(DATE_ID).text)
  end

  def table
    @table ||= Nokogiri::HTML(raw_html).css(TABLE_ID)
  end

  def counties
    @counties ||= table.css('tr > td[1]').map(&:text)[1..-2]
  end

  def rows
    @rows ||= begin
      table.css('tr > td').map(&:text)[5..-6].each_slice(5).map { |slice| { slice.first => slice[1..] } }
    end
  end

  # state did not provide LTC data on 7/5/2020
  def rows_without_ltc_data
    @rows ||= begin
      table.css('tr > td').map(&:text)[3..-4].each_slice(3).map { |slice| { slice.first => slice[1..] } }
    end
  end
end
