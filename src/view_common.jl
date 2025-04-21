function moduleToolbar(title, items)
    toolbarItems = [toolbartitle(title)]
    append!(toolbarItems, items)
    return header(toolbar(toolbarItems))
end