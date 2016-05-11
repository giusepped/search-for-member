# Search members

[![Build Status](https://travis-ci.org/giusepped/search-for-member.svg?branch=master)](https://travis-ci.org/giusepped/search-for-member)
[![Coverage Status](https://coveralls.io/repos/github/giusepped/search-for-member/badge.svg?branch=master)](https://coveralls.io/github/giusepped/search-for-member?branch=master)
[![Code Climate](https://codeclimate.com/github/giusepped/search-for-member/badges/gpa.svg)](https://codeclimate.com/github/giusepped/search-for-member)
[![Dependency Status](https://gemnasium.com/giusepped/search-for-member.png)](https://gemnasium.com/giusepped/search-for-member)


Overview
-------
This is a very basic Rails app that lets you search for members of both houses of Parliament using a keyword that represents one of their interests (e.g. "Housing", "Yorkshire", "Africa" etc). Once you get a list of members back, you can click on each one of them to get a bio page of that particular member

## Installation

Make sure to have Ruby, Rails and Redis installed before starting.

In your terminal do the following

```bash
$ git clone https://github.com/giusepped/search-for-member.git
$ cd search-for-member
$ bundle install
```

In a new tab, start a redis server

```bash
$ redis-server
```

You can now start the Rails server

```bash
$ rails s # -b 0.0.0.0 when running on a VM
```

## Testing

Run the rake spec task to run both the feature and unit tests(make sure the redis server is still running)

```sh
$ rake spec
```

