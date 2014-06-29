
# NOTE: this is for setting up test data in DEVELOPMENT, BUT the languages are (already) 
# set up in db/seeds.rb as they are real production values that should not be necessary
# to regenerate over and over again

# to execute this file... rake db:users

namespace :db do

  desc "remove and recreate users"

  task :users => :environment do

    Rake::Task['db:reset'].invoke
    
    @danish = Language.find_by_code("da")
    @english = Language.find_by_code("en")
    @spanish = Language.find_by_code("es")
    @italian = Language.find_by_code("it")
    @japanese = Language.find_by_code("ja")
    
    adm = User.create!( name:"admin",     email: "admin@test.com",       language: @english, activated: true, admin: true )
    pat = User.create!( name:"patconley", email: "pconley312@gmail.com", language: @english, activated: true, admin: true )
    tim = User.create!( name:"tim",       email: "timConley@test.com",   language: @english, activated: true )
    
    [@spanish].each { |language| adm.ranks.create!(score: 100, language_id: language.id )}
    [@japanese].each { |language| pat.ranks.create!(score: 100, language_id: language.id )}
    [@japanese,@spanish].each { |language| tim.ranks.create!(score: 100, language_id: language.id )}
    
    puts "Languages:"
    Language.all.each { |language| puts "   #{language.name}" }
    
    puts "Users:"
    User.all.each do |user| 
      languages = user.languages.collect { |language| language.name }.join(" | ")
      puts "   #{user.id}: #{user.name} #{user.language.name} [#{languages}]"
    end
    puts ""
                 
  end
  
end