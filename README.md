# Attendance

## Usage

Visit http://attendance.wdidc.org/

When logging in, grant access to the wdidc organization if you have not done so.

## Local Setup

**Clone the repo:**

    $ git clone https://github.com/jshawl/sinatra-login-with-github.git

**Install Dependencies**

    $ cd sinatra-login-with-github/
    $ bundle install
    
**Set ENV variables**

I keep my ENV variables in a local env.rb file, much like this one:

    ENV['GH_BASIC_CLIENT_ID'] = '...'
    ENV['GH_BASIC_SECRET_ID'] = '...'
    ENV['GH_URL'] = 'http://localhost:4567'
    
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
