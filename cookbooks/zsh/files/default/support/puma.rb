#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'foreman/procfile'

system(Foreman::Procfile.new("Procfile")["web"])

