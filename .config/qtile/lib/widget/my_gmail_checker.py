import random

# from libqtile.log_utils import logger
from libqtile.widget import base


class MyGmailChecker(base.ThreadPoolText):
    """
    My simple gmail checker.
    """

    defaults = [
        ("update_interval", 5, "Update time in seconds."),
        ("display_fmt", "{0}", "Display format"),
    ]

    def __init__(self, **config):
        base.ThreadPoolText.__init__(self, "", **config)
        self.add_defaults(MyGmailChecker.defaults)

    def poll(self):
        return self.display_fmt.format(str(random.randint(1, 10)))
