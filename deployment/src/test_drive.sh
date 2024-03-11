#!/bin/bash

# Create a new tmux session
session_name="test_drive_$(date +%s)"
tmux new-session -d -s $session_name

# Split the window into three panes
tmux selectp -t 0    # select the first (0) pane
tmux splitw -v -p 50 # split it into two halves
tmux selectp -t 0    # go back to the first pane
tmux splitw -h -p 50 # split it into two halves

# Run the roslaunch command in the first pane
tmux select-pane -t 0
tmux send-keys "source ../../../catkin_ws/devel/setup.bash" Enter
tmux send-keys "source ../../../rosvar.bash" Enter
tmux send-keys "roslaunch vint_jackal_remote.launch" Enter

# Run the teleop.py script in the second pane
tmux select-pane -t 1
tmux send-keys "conda activate vint_deployment" Enter
tmux send-keys "source ../../../catkin_ws/devel/setup.bash" Enter
tmux send-keys "source ../../../rosvar.bash" Enter
tmux send-keys "rosrun teleop_twist_keyboard teleop_twist_keyboard.py cmd_vel:=cmd_vel_mux/input/teleop" Enter

# Attach to the tmux session
tmux -2 attach-session -t $session_name