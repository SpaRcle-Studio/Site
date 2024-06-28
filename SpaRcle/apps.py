from django.apps import AppConfig
from termcolor import colored

from SpaRcle.core import server_updater


class SpaRcleConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'SpaRcle'

    def ready(self):
        print(colored('Initializing application...', 'green'))
        server_updater.run_server_updater()
