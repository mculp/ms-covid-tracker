require 'hanami/interactor'

class Scrape
  include Hanami::Interactor

  WEBSITE_URL = 'https://msdh.ms.gov/msdhsite/_static/14,0,420.html'
  TABLE_ID    = '#msdhTotalCovid-19Cases'

  attr_reader :raw_html

  def initialize(file = WEBSITE_URL)
    @raw_html = read(file)
  end

  def call
    rows.each { |row| CountyUpdateRepository.new.from_table_row_hash(row) }
  end

  private

  def read(file)
    if file.start_with?('.') || file.start_with?('/')
      File.read(file)
    else
      HTTParty.get(file)
    end
  end

  def table
    @table ||= Nokogiri::HTML(@raw_html).css(TABLE_ID)
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
