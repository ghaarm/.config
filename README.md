# About

I'm not a programm developer but a physician. Thanks to friends (shout out to Ihti and Leon) I have been introduced to Neovim and then started my journey into the terminal and app configuration.

Hence, to be honest actually I don't really know what I do, it is just copy pasting and asking ChatGPT a lot.

A really big help was and ist [Josean Martinez Youtube Chanel](https://www.youtube.com/@joseanmartinez) and [blog](https://www.josean.com/). Thanks a lot!

Working on an intel Mac running macOS 13.6.9


## Nvim
Mostly I use Nvim for latex and r code as an substitution for RStudio.

### Nvim plugins
The Nvim Plugins folder and their lua code is quite messy - sorry for that, but as mentioned above - I actually don't really know what I wrote in that code and the lua files contain a lot of commented code just as fast back up.

Hopefully I can rework them to become less messy.


### R-nvim
For configurating r-nvim [Rohit Farmers tutorial](https://docs.rohitfarmer.com/editors/nvimr-r-ide/) was a big help. Thanks a lot!

### Vimtex
For configurating Vimtex [Ben Brast-McKie's github page](https://github.com/benbrastmckie/.config/tree/master/nvim) was really useful, especially the snippets. Thanks for posting your .config!

Also helpful was [Ben Brast-McKie's Youtube chanel](https://www.youtube.com/@benbrastmckie/videos).

#### Sioyek (PDF viewer)
As many recommended I first tried Zathura as the pdf viewer synced with vimtex. Although trying multiple recommendations found online, backward search was not working. Hence, I first used Skim but than changed to Sioyek, which also has vim keybindings, is highly customizable and has very nice features when you are reading a lot of scientific PDFs.

Sioyeks configuration files aren't located in the .config, but in "/Applications/sioyek.app/Contents/MacOS/". For better management I moved them to .config and used a symbolic link in the before mentioned sioyek folder.
