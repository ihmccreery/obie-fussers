require 'net/http'

# A utility class to construct emails from pages
class Page
  attr_reader :emails

  # build a page given a page number
  def initialize(page_number)
    @page = Net::HTTP.get(URI("http://new.oberlin.edu/home/directory.dot?pageNumber=#{page_number}&entryType=student"))
    @emails = to_emails
  end

  private

  # this hideous regex matches any line that has a script to write an email, and scrapes the name from it
  EMAIL_REGEX = /document\.write\('(?<name>.+)'\);document\.write\('@'\);document\.write\('oberlin.edu'\)/

  # scrape emails from the page
  def to_emails
    emails = @page.lines.map do |line|
      if m = EMAIL_REGEX.match(line)
        m[:name] + '@oberlin.edu'
      end
    end
    return emails.compact
  end
end
