require 'test_helper'

class LanguageTest < ActiveSupport::TestCase
  
  setup do
    @minumum_language_params = { name: "pirate", code: "jr", flag: "xx" }
  end
  
  test "should create language with minumum params" do    
    language = Language.new(@minumum_language_params)
    assert language.save, "Failed to save the language with minimum params"
  end
  
  test "should not save language without name" do
    @minumum_language_params.delete(:name)
    language = Language.new(@minumum_language_params)
    assert_not language.save, "Saved a language without an name"
  end
  
  test "should not save language without code" do
    @minumum_language_params.delete(:code)
    language = Language.new(@minumum_language_params)
    assert_not language.save, "Saved a language without a code"
  end
  
  test "should not save language without flag" do
    @minumum_language_params.delete(:flag)
    language = Language.new(@minumum_language_params)
    assert_not language.save, "Saved a language without a flag"
  end
  
end
