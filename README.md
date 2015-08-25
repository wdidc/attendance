# Attendance

## Usage

Visit http://attendance.wdidc.org/

When logging in, grant access to the wdidc organization if you have not done so.

For development, use the "example" weekday: http://localhost:4567/example

## Local Setup

### Clone the repo:

    $ git clone git@github.com:wdidc/attendance.git
    $ cd attendance

### Install Dependencies

    $ bundle install

No local database required.  It persists via API calls.

### Register a new GitHub Developer Application

- Visit https://github.com/settings/developers
- Choose "Register new application"
  - Fill in "Application Name"
    - dev (recommend): 'dev-wdi-attendance'
    - production: 'attendance.wdidc.org'
  - Fill in "Authorization callback URL" using the app's callback path.
    - dev (probably): 'http://localhost:4567/auth/github/callback'
    - production: 'http://attendance.wdidc.org/auth/github/callback'
  - the rest are optional

- Gotcha: The path for Authorization callback url used to be `callback`.  Update it to the standard oAuth path seen above.


### Set ENV variables

This app loads ENV variables from the (uncommitted) env.rb file.  
- Copy "env.example.rb" to "env.rb" and
- update the stated values from the GitHub Developer Application you created above.

## Upgrade Actions: Aug 2015

- Before:
  - update env.rb
    - copy GH_SESSION_SECRET to SESSION_SECRET
- After:
  - update your local env.rb
    - remove GH_URL
    - remove GH_SESSION_SECRET

## License

The MIT License (MIT)

Copyright (c) 2014 Jesse Shawl

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
