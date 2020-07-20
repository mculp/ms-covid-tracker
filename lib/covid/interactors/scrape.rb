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
    @county_updates = rows.map do |row|
      CountyUpdateRepository.new.create_from_row(row: row, date: date)
    end
  end

  def parsed_html
    @parsed_html ||= Nokogiri::HTML(raw_html)
  end

  def date
    @date ||= Date.parse(parsed_html.css(DATE_ID).text)
  end

  def table
    @table ||= parsed_html.css(TABLE_ID)
  end

  def counties
    @counties ||= table.css('tbody > tr > td[1]').map(&:text)
  end

  def rows
    @rows ||= begin
      table
        .css('tbody > tr > td')
        .map(&:text)
        .each_slice(slice_size)
        .map { |slice| { slice.first => slice[1..] } }
    end
  end

  def without_ltc_data?
    table.css('thead > tr > td').size == 3
  end

  def slice_size
    without_ltc_data? ? 3 : 5
  end
end
