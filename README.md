# About

I'm not a programm developer but a physician. Thanks to friends (shout out to Ihti and Leon) I have been introduced to Neovim and then started my journey into the terminal and app configuration.

Hence, to be honest actually I don't really know what I do, it is just copy pasting and asking ChatGPT a lot.

A really big help is [Josean Martinez Youtube Chanel](https://www.youtube.com/@joseanmartinez) and [blog](https://www.josean.com/). Thanks a lot!

Working on an intel Mac running macOS 13.6.9


## Nvim
Mostly I use Nvim for latex and r code as an substitution for RStudio and for example Texifier. Using one editor instead of several, really improved my workflow, especially as the startup time of those are significantly slower than Nvim's.

### Nvim plugins
The Nvim Plugins folder and their lua code is quite messy - sorry for that. As mentioned above - I actually don't really know what I do, but it somewhow works. The lua files often contain a lot of commented code just as fast back up.

Hopefully I can rework them to become less messy.


### R-nvim
For configurating r-nvim [Rohit Farmers tutorial](https://docs.rohitfarmer.com/editors/nvimr-r-ide/) was a big help. Thanks a lot!

### Vimtex
For configurating Vimtex [Ben Brast-McKie's github page](https://github.com/benbrastmckie/.config/tree/master/nvim) was really useful, especially the snippets. Thanks for posting your .config!

Also helpful was [Ben Brast-McKie's Youtube chanel](https://www.youtube.com/@benbrastmckie/videos).

#### Sioyek (PDF viewer)
As many recommended I first tried Zathura as the pdf viewer synced with vimtex. Although trying multiple recommendations found online, backward search was not working. Hence, I first used Skim but than changed to Sioyek, which also has vim keybindings, is highly customizable and has very nice features when you are reading a lot of scientific PDFs.

Sioyeks configuration files aren't located in the .config, but in "/Applications/sioyek.app/Contents/MacOS/". For better management I moved them to .config and used a symbolic link in the before mentioned sioyek folder.


## Terminal

First started with iTerm2 but than, after beeing impressed by Alacritty (without decorations), changed.

As previewing files, especially PDF, JPG and PNG really enhances my workflow I than changed to WezTerm, which as far as I can remember uses parts of Kitty's graphic protocoll. Unfortunately there were some keybindings like differentiation between left and right alt key, which I couldn't change but would have needed a lot of neural remapping.

With Kitty file preview with Yazi just works fine and within Yazi I can use vim keybindings as well, without having WezTerm's keybinding Problems. 
