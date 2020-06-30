require 'hanami/interactor'
require 'nokogiri'

class Scrape
  include Hanami::Interactor

  WEBSITE_URL = 'https://msdh.ms.gov/msdhsite/_static/14,0,420.html'
  DATE_ID     = '#assetNow_pageSubtitle'
  TABLE_ID    = '#msdhTotalCovid-19Cases'

  attr_reader :raw_html

  def initialize(raw_html)
    @raw_html = raw_html
  end

  def call
    rows.each { |row| CountyUpdateRepository.new.create(attributes_for_row(row)) }
  end

  def attributes_for_row(row)
    county = CountyRepository.new.find_or_create_by_name(row.keys.first)

    {
      date: date,
      county_id: county.id,
      cases: row[county.name][0],
      deaths: row[county.name][1],
      ltc_cases: row[county.name][2],
      ltc_deaths: row[county.name][3]
    }
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
end
