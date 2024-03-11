#!/bin/bash

# Create a new tmux session
session_name="record_bag_$(date +%s)"
tmux new-session -d -s $session_name

tmux selectp -t 0    # select the first (0) pane

# tmux send-keys "roslaunch vint_locobot.launch" Enter
tmux send-keys "source ../../../catkin_ws/devel/setup.bash" Enter
tmux send-keys "source ../../../rosvar.bash" Enter
tmux send-keys "echo \$ROS_IP" Enter
tmux send-keys "echo \$ROS_MASTER_URI" Enter

# Attach to the tmux session
tmux -2 attach-session -t $session_name