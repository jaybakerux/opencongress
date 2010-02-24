class WikiBill

  require 'hpricot'
  require 'open-uri'
  require 'timeout'

  attr_accessor :summary

  def initialize(url)
    puts url
    @url = url
    begin
      Timeout::timeout(3) {
        doc = Hpricot(open(url))
      }
      summary_content = (doc/"#Article_summary") 
      summary_content.search("sup").remove
      unless summary_content.blank?
         @summary = summary_content.inner_html
      else
         @summary = nil
      end
    rescue
      @summary = nil
    end 
  end

end
