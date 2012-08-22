require 'rubygems'
require 'mechanize'

agent = Mechanize.new
rescompURL = 'http://www.rescomp.berkeley.edu'
username = "ENTER CALNET ID HERE"
password = "ENTER CALNET PASSWORD HERE"

page = agent.get(rescompURL)
agent.get(rescompURL) do |page|
  # click on "Log In to Helpdesk" button
  login_page = page.links.find { |link| link.text == "Log In to Helpdesk" }.click
	
  # enter CalNet username
  # enter CalNet password
  # submit form
  account_page = login_page.form_with(:action => "/cas/login?service=https://www.rescomp.berkeley.edu/cgi-bin/pub/online-helpdesk/index.pl") { |form|
    form.field_with(:id => 'username').value = username
    form.field_with(:id => 'password').value = password
  }.submit
  
  # read usage information
  bandwidth_usage = account_page.content.match(/<th width="100">\s*Used\s*<\/th>\s*<td>\s*(.*)<\/td>/)
  
  puts bandwidth_usage[1]
end