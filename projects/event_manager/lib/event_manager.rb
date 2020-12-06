require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

puts "EventManager initialized."

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
  # rjust
  # If integer is greater than the length of str, returns a new String of length integer with str right 
  # justified and padded with padstr; otherwise, returns str.
end

def legislators_by_zipcode(zipcode)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'
  # https://www.googleapis.com/civicinfo/v2/representatives?address=80203&levels=country&roles=legislatorUpperBody&roles=legislatorLowerBody&key=AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw

  begin 
    civic_info.representative_info_by_address(
      #below 3 are the parameters we are sending across
      address: zipcode,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
    # .officials is the nested array where the information lies 
  rescue #for if zipcode is a dummy value such as 00000 // Exceptions handling
    "You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials"
  end
end

def save_thank_you_letter(id,form_letter)
  #make directory if not yet exists
  Dir.mkdir("output") unless Dir.exists?("output")
  #name file using id as a uniq identifier
  filename = "output/thanks_#{id}.html"
  #open the file as writable, then write/puts in the form
  File.open(filename,'w') do |file|
    file.puts form_letter
  end
end

contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol
#note: all file paths are relative to where cdir // current directory is
#open the CSV file with CSV module
#set headers to true, so the file can distinguish first row (as header)
#convert each header (i.e first row per column) as symbol so it is referrable

template_letter = File.read "form_letter.erb"
#read the template, which already has ERB syntax
erb_template = ERB.new template_letter
#convert the file into a ERB object

contents.each do |row|
    id = row[0] #see that the first item in the row is a ID number, it has a "" header
    name = row[:first_name] #we find the row corresponding symbol
    zipcode = clean_zipcode(row[:zipcode]) 
    legislators = legislators_by_zipcode(zipcode)

    # binding allows for ERB to be aware of the variables such as zipcode
    form_letter = erb_template.result(binding)
    
    save_thank_you_letter(id,form_letter)
end