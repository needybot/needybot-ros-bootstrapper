#!/bin/bash
#-------------------------------------------------------------------------------
# This script is will get your Ubuntu 12/14.04 LTS instance up and running with
# ROS Indigo from scratch.
#
# This was based on the official ROS Indigo install instructions found on the
# ROS wiki: http://wiki.ros.org/indigo/installation/Ubuntu
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Only want to run this if the target system is Ubuntu
#-------------------------------------------------------------------------------
if [ $(lsb_release -is) != "Ubuntu" ];
then
        echo "This bootstrap script is only for Ubuntu 12.04 and 14.04 LTS \
         distributions.\nIf you need to install ROS on a different \
         distribution check out the ROS wiki for more help: \
         http://wiki.ros.org/indigo/installation"
        exit 1
fi

#-------------------------------------------------------------------------------
# Update apt sources/keys with latest ROS stuff
#-------------------------------------------------------------------------------
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > \
        /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://pool.sks-keyservers.net --recv-key 0xB01FA116
sudo apt-get update && sudo apt-get upgrade -y

#-------------------------------------------------------------------------------
# Default packages
#-------------------------------------------------------------------------------
packages=(
    # Add any packages you want installed on your system here
    # git
    # openssh-server
)

#-------------------------------------------------------------------------------
# set up catkin workspace structure & clone needybot repository
#-------------------------------------------------------------------------------
if [ -d /home/$USER/catkin_ws ]; then
    if [ ! -d /home/$USER/catkin_ws/src ]; then
        mkdir /home/$USER/catkin_ws/src
    fi
else
    mkdir -p /home/$USER/catkin_ws/src
fi

#-------------------------------------------------------------------------------
# Adjust the package deps depending on the Ubuntu release
#-------------------------------------------------------------------------------
case $(lsb_release -sc) in
    trusty*)
        # Ubuntu 14.04 LTS
        version = `lsb_release -a | grep Description | awk '{print $3}' | tail -n 1`
        if [ ${version} == "14.04.2" ]; then
            packages=(
                ${packages[@]}
                libgl1-mesa-dev-lts-utopic
                )
        elif [ ${vesrion} == "14.04.3" ]; then
            packages=(
                ${packages[@]}
                libc6:i386
                libgl1-mesa-dri-lts-vivid:i386
                libgl1-mesa-glx-lts-vivid:i386
                )
        fi
        ;;
    precise*)
        # Ubuntu 12.04 LTS
        packages=(
            ${packages[@]}
            xserver-xorg-dev-lts-utopic
            mesa-common-dev-lts-utopic
            libxatracker-dev-lts-utopic
            libopenvg1-mesa-dev-lts-utopic
            libgles2-mesa-dev-lts-utopic
            libgles1-mesa-dev-lts-utopic
            libgl1-mesa-dev-lts-utopic
            libgbm-dev-lts-utopic
            libegl1-mesa-dev-lts-utopic
        )
        ;;
esac

#-------------------------------------------------------------------------------
# Install deps and get ROS set up
#-------------------------------------------------------------------------------
packages=(
    ${packages[@]}
    ros-indigo-desktop-full
)
sudo apt-get install -y ${packages[@]}
sudo rosdep init && rosdep update

