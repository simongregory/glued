# encoding: utf-8

$LOAD_PATH.push File.join(File.dirname(__FILE__), '..', 'lib')
$LOAD_PATH.push File.dirname(__FILE__)

require 'coveralls'
Coveralls.wear!

require 'glued'

require 'rspec'
require 'rspec/autorun'
