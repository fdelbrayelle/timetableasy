# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

    def liams_link_to(text, path, classname)
      out = "<span class='" + classname + "'>"
      out += link_to text, path
      out += "</span>"
      out
    end

end
