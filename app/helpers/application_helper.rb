module ApplicationHelper
    def page_title(title = '')
        current_page = title
        if title.present?
            @full_title = current_page + ' ' + '|' + ' ' + "The Beginner Rails App"
        else
            @full_title = "The Beginner Rails App"
        end
        @full_title
    end
end
