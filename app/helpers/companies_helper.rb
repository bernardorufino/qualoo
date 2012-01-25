module CompaniesHelper

  def categories_sentence(categories)
    categories.map{|c| link_to(c.name, category_path(c))}.to_sentence(
      :two_words_connector => " e ",
      :last_word_connector => ", e "
    ).html_safe;
  end
  
end
