module Categories
  class Gertuko
    EDUCATION=0
    ENTERTAINMENT=1
    ADVENTURE=2
    GRUB=3
    
    ALL=[EDUCATION,ENTERTAINMENT, ADVENTURE, GRUB]
  end
  
  class BoiseWeekly
    
    @music = %w(Music
    Alternative
    Americana
    Blues
    Country
    Electronic
    Hip-Hop/Rap
    Jazz
    Metal
    Pop
    Punk
    R&B
    Reggae
    Rock
    Singer-Songwriter
    Variety
    World)
    
    @adventure = ['Sports & Fitness']
    @entertainment = ['Festivals & Events']
    @grub = ['Food & Drink']
    
    def self.parse_from_string category
      if @music.include? category or @entertainment.include? category
        Categories::Gertuko::ENTERTAINMENT
      elsif @adventure.include? category
        Categories::Gertuko::ADVENTURE
      elsif @grub.include? category
        Categories::Gertuko::GRUB
      else
        1
      end
    end
  end
end