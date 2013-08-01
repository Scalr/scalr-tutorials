Continuous Integration
======================

Overview
--------

This tutorial lets you simulate a continuous integration workflow:


  1. The CI server notifies the Build server a new release is available
     (This will be you on your laptop)
  2. The Build server creates a build, and uploads it somewhere it's available
     to the Client servers (we'll just pretend this location exists here)
  3. The Client servers download the build and installs it


Custom Events
-------------

Define two custom events: `OnCodeReady` and `OnBuildReady`.


Firing the events
-----------------

### Command Line Tools ###

Install the Scalr command line tools (scalrtools: `easy_install scalr`)


### Fire the event ###

    scalr fire-custom-event -s 7d875be4-6ebc-4162-957a-32e369220039 \
                            -n CodeReady \
                            -v branch=feature/new

