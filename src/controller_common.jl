
@created """
console.log('This app has just been created!');
document.querySelector('.layout_root').hidden = false;
"""

"""
    Redirect to some url path.
    eg. `@run jsredirect("/some/url/path")`
"""
function jsredirect(path)
    return """window.location.href = '$path'"""
end

"""
    Notify the user with a message.
    eg. `@run notifyError("Oh-oh")`
"""
function notifyError(message)
    @error message
    return """
        Quasar.Notify.create({
            message: '$message',
            position: 'center',
            type: 'negative'
        })
    """
end