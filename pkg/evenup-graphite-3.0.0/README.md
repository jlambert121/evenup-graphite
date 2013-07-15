What is it?
===========

A puppet module that installs graphite (carbon, whisper, web) from packages,
configures the applications, and manages the services.  The packages this is
based on are created from Dan Carley's [spec files](https://github.com/dcarley/graphite-rpms).


Why another graphite module?
----------------------------
Move to paramertized classes
Better configuration
Tests


Usage:
------

This module pretty much requires hiera to be able to set all of the configuration
options.

<pre>
  graphite::carbon::config::log_updates: true
  graphite::carbon::service::relay_enabled: true
</pre>

Install
<pre>
  class { 'graphite': }
</pre>


Known Issues:
-------------
Only tested on CentOS 6


License:
_______

Released under the Apache 2.0 licence


Contribute:
-----------
* Fork it
* Create a topic branch
* Improve/fix (with spec tests)
* Push new topic branch
* Submit a PR
