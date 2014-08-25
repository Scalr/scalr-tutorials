#coding:utf-8
import os
import shutil
import contextlib
import requests
import subprocess

TUTORIALS_ORG = "scalr-tutorials"
TUTORIALS_LIST = "https://api.github.com/orgs/{0}/repos".format(TUTORIALS_ORG)


@contextlib.contextmanager
def chdir(dirname):
    curdir = os.getcwd()
    try:
        os.chdir(dirname)
        yield
    finally:
        os.chdir(curdir)


if __name__ == "__main__":
    # Fetch the reference data
    tutorials = requests.get(TUTORIALS_LIST).json()
    repos = {repo["name"]: repo["clone_url"] for repo in tutorials}

    # This is what we want
    existing_tutorials = set(repos)

    # This is what we have
    here = os.path.dirname(os.path.abspath(__file__))
    local_tutorials = set((
        name for name in os.listdir(here)
        if os.path.isdir(os.path.join(here, name))
        and not name.startswith(".")
    ))

    for extra_tutorial in local_tutorials - existing_tutorials:
        print "Removing extra tutorial: {0}".format(extra_tutorial)
        shutil.rmtree(os.path.join(here, extra_tutorial))

    for missing_tutorial in existing_tutorials - local_tutorials:
        print "Adding missing tutorial: {0}".format(missing_tutorial)
        with chdir(here):
            clone_url = repos[missing_tutorial]
            subprocess.check_call(["git", "submodule", "add", clone_url, missing_tutorial])

    print "Updating all modules"
    subprocess.check_call(["git", "submodule", "foreach", "git", "pull"])

    print "Done!"
