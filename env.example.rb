ENV['SESSION_SECRET'] = "attendance" + ('x' * 30) # meets minimum requirement of 30 chars long
# While the above SESSION_SECRET is fine for development
# For production, we recommend generating a SESSION_SECRET in irb using SecureRandom.hex and copy/paste
ENV['GH_BASIC_CLIENT_ID'] = 'Client ID from associated Github Developer Application, generated by Github'
ENV['GH_BASIC_CLIENT_SECRET'] = 'Client Secret from associated Github Developer Application, generated by Github'
