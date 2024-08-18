Yabai + SKHD


# https://www.josean.com/posts/yabai-setup 

# change window focus within space
shift + alt - j : yabai -m window --focus south
shift + alt - k : yabai -m window --focus north
shift + alt - h : yabai -m window --focus west
shift + alt - l : yabai -m window --focus east

#change focus between external displays (left and right)
# toggle window float
shift + alt - t : yabai -m window --toggle float --grid 4:4:1:1:2:270

# maximize a window
shift + alt - m : yabai -m window --toggle zoom-fullscreen

# balance out tree of windows (resize to occupy same area)
shift + alt - e : yabai -m space --balance

hift + alt - p : yabai -m window --space prev;
shift + alt - n : yabai -m window --space next;

