# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# ISO 639-1 Code is used for the language code
# but the ISO country codes are used for a flag icon

Language.create! :code=>"da", :flag=>"dk", :name=>"Dansk"
Language.create! :code=>"en", :flag=>"gb", :name=>"English"
Language.create! :code=>"es", :flag=>"es", :name=>"Español"
Language.create! :code=>"ja", :flag=>"jp", :name=>"日本語"
Language.create! :code=>"it", :flag=>"it", :name=>"Italiano"
