# Mincer - batch processing daemon

## Summary

Listen incoming directory for new files, process them and put
processing results to the output directory.

Uses inoticoming based on inotify lib. Mincer provides a few useful
functions, not found in the inoticoming tool:

* more friendly and convenient command line interface allow
 to start and stop Mincer daemon;
* simple but flexible configuration file with a lot of reasonable defaults;
* can save processed files (optionally gzipping them) in a separate directory;
* improved logging of what is going on within the processor.

Stacking multiple instances of Mincer allows to build
complex queued data processing conveyers. To do so, just configure
your first Mincer instance ``OUTPUT_DIR`` to the ``INCOMING_DIR`` of the
second one.

## Usage

The package doesn't provide a system daemon but only
a few scripts which can be used to build your own daemons.

## Daemon creation mini-howto

1. Create a root directory for your Mincer instance, say /var/mincer1;
2. Create a callback script ``callback.sh`` inside the root directory.
 Take a ``callback.sh.skeleton`` as a start point. It must take an absolute
 file name of incoming data file as first argument. It must create result
 file (or files) inside its current directory (actually this can be
 overrided. See examples);
3. Create your own Mincer configuration file based on
 mincer.conf.example, provided inside the upstream tarball.
 You have to define at least ROOT_DIR and FILENAME_REGEXP variables.
 Save the created file as ``/var/mincer1/mincer.conf``;
4. Start the Mincer daemon with ``mincer /var/mincer1/mincer.conf``. Note
 only the very first command will start the daemon and all subsequent
 invocations will gracefully exit.

Now you can:

* add your data files to the ``/var/mincer1/incoming`` directory;
* examine what is going on in the ``/var/mincer1/processing.log``;
* stop the daemon with ``mincer /var/mincer1/mincer.conf stop``.
