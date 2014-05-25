module ApplicationHelper
    
    def cool
        base_title = "campUS"
        if @title.nil?
            base_title
        else
         "#{base_title} | #{@title} "
        end
    end
    
  end
