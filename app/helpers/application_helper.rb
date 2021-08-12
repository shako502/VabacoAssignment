module ApplicationHelper
end

def nav_bar
    content_tag(:ul, class: "navbar-nav me-auto mb-2 mb-lg-0") do
        yield
    end
end

def nav_link(text, path)
    options = current_page?(path) ? { class: "nav-link active" } : {class: "nav-link"}
    content_tag(:li, class: "nav-item") do
      link_to text, path, options
    end
end
