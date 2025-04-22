
@created """
console.log('This app has just been created!');
document.querySelector('.layout_root').hidden = false;
"""

function jsredirect(path)
    return """window.location.href = '$path'"""
end

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