class PagesController < ApplicationController
  
  skip_before_filter :authenticate_user
  
  def home
      puts "\n\n***home page controller"
      @languages = Language.all
  end
  
end
