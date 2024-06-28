from termcolor import colored
import git
import time
import os
import threading


def pull_changes():
    repo = git.Repo(os.getcwd())
    origin = repo.remotes.origin
    origin.fetch()

    # repo.is_dirty(untracked_files=True) or
    if repo.head.commit != origin.refs.master.commit:
        print(colored('The server repository has changes, reload...', 'yellow'))
        origin.pull()
        restart_server()


def restart_server():
    print(colored('Restarting server...', 'yellow'))
    exit(100)


def changes_checker():
    while True:
        pull_changes()
        time.sleep(1)


def run_server_updater():
    threading.Thread(target=changes_checker, daemon=True).start()
