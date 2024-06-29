from termcolor import colored
import git
import time
import os
import threading
import signal


def pull_changes():
    repo = git.Repo(os.getcwd())
    origin = repo.remotes.origin
    origin.fetch()

    # repo.is_dirty(untracked_files=True) or
    if repo.head.commit != origin.refs.master.commit:
        print(colored('[Server] The server repository has changes!', 'yellow'))
        origin.pull()
        restart_server()


def restart_server():
    print(colored('[Server] Restarting the server...', 'yellow'))

    if not os.path.exists(os.getcwd() + '/Cache'):
        os.makedirs(os.getcwd() + '/Cache')

    with open(os.getcwd() + '/Cache/reload', 'w') as reload:
        reload.close()

    os.kill(os.getpid(), signal.SIGINT)


def changes_checker():
    print(colored('[Server] Server updater successfully started!', 'blue'))
    while True:
        pull_changes()
        time.sleep(5)


def run_server_updater():
    threading.Thread(target=changes_checker, daemon=True).start()