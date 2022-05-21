from libqtile.utils import lazify_imports
from libqtile.widget.import_error import make_error


widgets = {"MyGmailChecker": "my_gmail_checker"}

(
    __all__,
    __dir__,
    __getattr__,
) = lazify_imports(widgets, __package__, fallback=make_error)
