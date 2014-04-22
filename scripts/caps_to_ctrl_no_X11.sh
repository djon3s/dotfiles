#!/usr/bin/env bash
# Converts caps to a control key without needing X etc
# useful when you've borked a kernel install and get
# dropped into a virtual terminal or for spiritually
# pure aesthetes who worship the austere divinities of 
# text and pipe.
sudo dumpkeys | head -1 > ~/.keymap_caps2ctrl_no_X
echo "keycode 58 = Control" >> ~/.keymap_caps2ctrl_no_X
sudo loadkeys ~/.keymap_caps2ctrl_no_X

# to unload, sudo loadkeys -d
