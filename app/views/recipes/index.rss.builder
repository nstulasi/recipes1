xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Recipe-U-Like!!"
    xml.description "Enjoy the tasty ride! ...."
    xml.link recipes_url

    for recipe in @recipes
      xml.item do
        xml.title recipe.name
        
        xml.pubDate recipe.created_at.to_s(:rfc822)
        xml.link recipe_url(recipe)
        xml.guid recipe_url(recipe)
      end
    end
  end
end

