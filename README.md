# needybot-ros-bootstrapper
Performs a complete installation of ROS Indigo on Ubuntu 12.04/14.04 LTS
systems.

This bootstrap script is based off of the official ROS Indigo installation
instructions found [here](http://wiki.ros.org/indigo/Installation/Ubuntu).

**Currently this script fails to execute properly on the current Ubuntu release (14.04.3) due to package dependencies that are as-of-yet not available for the dot release. If you are on 14.04.3, please refer to the 
manual instructions found in the link above.**

##Quickstart
To get started, just fire up your clean Ubuntu system, and rock this:

``` bash
$ curl https://raw.githubusercontent.com/wieden-kennedy/ros-indigo-bootstrap/master/ros-bootstrap.bash > ros-bootstrap.bash
# optionally compare the md5 of the curled file 
# with the supplied md5.txt file (good idea)
$ cat md5.txt               # outputs       e1da2657b8cf193d42d1f44793c4beab
$ md5 -q ros-bootstrap.bash # should output e1da2657b8cf193d42d1f44793c4beab
# hooray!
$ /bin/bash ros-bootstrap.bash
```

This will install all of the dependencies (including catkin) needed to run ROS
Indigo.

Contributing
------------

See our contribution guidelines [here](CONTRIBUTION_GUIDELINES.md).

License
-------

This project is release under Apache 2.0. Please see the [LICENSE](LICENSE) file for more details.
