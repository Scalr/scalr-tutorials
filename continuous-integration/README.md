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

Define two custom events: `CodeReady` and `BuildReady`.


Firing the events
-----------------

### Command Line Tools ###

Install the Scalr command line tools (scalrtools: `easy_install scalr`)


### Fire the event ###

    scalr fire-custom-event -s $SERVER_ID \
                            -n CodeReady \
                            -v branch=feature/new


You'll have to retrieve the retrieve the Server ID from the Scalr UI (or API)
