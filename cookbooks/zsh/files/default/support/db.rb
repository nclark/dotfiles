#!/usr/bin/env ruby

require 'yaml'

config = YAML.load(File.open('config/database.yml'))['development']

system "mysql -u#{config['username']} -p#{config['password']} -h#{config['host']} #{config['database']}"
