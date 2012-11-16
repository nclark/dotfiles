#!/usr/bin/env ruby

require 'yaml'

database = YAML.load(File.open('config/database.yml'))['development']['database']

system "mysql -uroot #{database}"
