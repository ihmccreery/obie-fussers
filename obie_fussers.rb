# A script to scrape student emails from Fussers

require_relative 'page'

File.open('emails.txt', 'w') do |f|
  page_number = 0
  loop do
    # get the next page
    page = Page.new(page_number += 1)

    if page.emails.empty?
      break
    else
      puts "writing page #{page_number} emails:"

      page.emails.each do |email|
        f.write "#{email}\n"
        puts "  #{email}"
      end
      f.flush

      puts "done"
      puts
    end
  end
end
