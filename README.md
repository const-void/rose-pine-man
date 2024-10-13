# rose-pine-man
rose-pine color theme for `man` page viewing.

![rose-pine-man](https://github.com/const-void/rose-pine-man/blob/main/doc/rose-pine-man.png)


# Key features
* Rose-pine colors are available for terminal use beyond man colors
* Customizable + tweakable _truecolor_ man themes
* Functions to help us learn about truecolor terminal colors

# Quick Installation
Clone + add to `.zshrc`
```zsh
$ mkdir -p ~/.config/zsh/
$ cd ~/.config/zsh
$ git clone https://github.com/const-void/rose-pine-man.git
$ vi ~/.zshrc
...
source ~/.config/zsh/rose-pine-man/rose-pine-man.zsh
...
$ . ~/.zshrc
$ man zsh
```

![rose-pine-man](https://github.com/const-void/rose-pine-man/blob/main/doc/rose-pine-man.png)

Want to try other `rose-pine` themes or a `custom` one? We got you.  Need a transparent background? You are good.


## rose-pine-moon
```zsh
# ~/.zshrc
source ~/.config/zsh/rose-pine-man/rose-pine-man.zsh
colorize_man rose-pine-moon
# colorize_man rose-pine-moon transparent 
```


![rose-pine-moon-man](https://github.com/const-void/rose-pine-man/blob/main/doc/rose-pine-moon-man.png)



## rose-pine-dawn
```zsh
# ~/.zshrc
source ~/.config/zsh/rose-pine-man/rose-pine-man.zsh
colorize_man rose-pine-dawn
# colorize_man rose-pine-dawn transparent
```

![rose-pine-dawn-man](https://github.com/const-void/rose-pine-man/blob/main/doc/rose-pine-dawn-man.png)

## customized theme
```zsh
# ~/.zshrc
source ~/.config/zsh/rose-pine-man/rose-pine-man.zsh
colorize_man custom
# colorize_man custom transparent
```

Please see the tips+tricks section for customization hints!

## transparency?
By default, we set the background to match the rose-pine theme.  However, if you are running a terminal with transparency and want to keep the transparency setting, simply pass in `transparent` as an optional second parameter. This activates logic that ignores setting background colors - only your terminal emulator can do actual transparency (alacritty et)

```zsh
# ~/.zshrc
source ~/.config/zsh/rose-pine-man/rose-pine-man.zsh
colorize_man rose-pine-moon transparent
```

## Credits
* oh-my-zsh -- https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/colored-man-pages/colored-man-pages.plugin.zsh
* less termcap -- https://unix.stackexchange.com/questions/108699/documentation-on-less-termcap-variables/108840#108840
* terminal truecolor -- https://github.com/termstandard/colors

### Try out different themes on the fly!
To try a different theme on the fly:
```zsh
$ colorize_man rose-pine
$ man zsh
$ colorize_man rose-pine-moon
$ man zsh
$ colorize_man rose-pine-dawn
$ man zsh
$ colorize_man custom
$ man zsh

## Settings that respect transparency
$ colorize_man rose-pine transparent
$ man zsh
$ colorize_man rose-pine-moon transparent
$ man zsh
$ colorize_man rose-pine-dawn transparent
$ man zsh
```

# Terminal notes
**Assumptions:**
* Terminal is truecolor ready...there are NO checks...use your eyes! (for now)
* Tested with `zsh` on OSX w/alacritty
* ANSI control character separator is `;`
* ANSI escape control character is `\033`


**Term notes:**
* OSX `Terminal.app` does not support true-color...at all.  Avoid for now.

# Tips and tricks
Some handy helper functions are included, prefixed with `term16m` to indicate they require truecolor (16 million colors) support.  

To use, invoke functions as commands inside an interactive terminal, and explore color theming! 

Color theming takes some trial and error.

## Testing 
When tweaking colors, it can be helpful to quickly test. 

Check out colors used by current color settings / theme...
```zsh
$ term16m_man_color_test
```

See all the themes in one go...handy when customizing!  Note, this will reset your theme to the default.
```zsh
$ term16m_man_theme_color_test
```

## Trying out new colors
Want to try different colors? No problem. `rose-pine.zsh` is intended to be modified by you! You do you. 

Theme colors are simply ANSI RGB values separated by ";" stored in the following environment variables:

| Variable              | Color Value                          |
| --------------------- | ------------------------------------ |
| `MAN_THEME_BG`        | Default background color (base)      |
| `MAN_THEME_TXT`       | Default foreground color             |
| `MAN_THEME_BG2`       | Secondary background color  (base+)  |
| `MAN_THEME_UNDERLINE` | Color that replaces underline        |
| `MAN_THEME_BOLD`      | Color that replaces bold             |
| `MAN_THEME_BLINK`     | Color that replaces blink            |
| `MAN_THEME_REVERSE`   | Color that replaces reverse          |

To change colors, simply set the above to ANSI RGB, where a byte is an integer 0-255.
```zsh
$ MAN_THEME_<setting>="<red byte>;<green byte>;<blue byte>"
$ man zsh
```

## Try out a completely new color
First, to get a feel for what an ANSI RGB value looks like:
```zsh
$ term16m_rgb_to_ansi_rgb 255 128 237
255;128;237
```

Simple enough, right? 

We know that finding RGB out in the wild is tough! So we have a helper function to convert hex to r;g;b:
```zsh
$ term16m_hex_to_ansi_rgb '#ff80ed'
255;128;237
```

Then set, say, text, to the color you like...`MAN_THEME_TXT`is super dramatic, so let's try that!
```zsh
$ MAN_THEME_TXT="255;128;237"
$ man zsh
```

If things go crazy, reset your theme to one of the defaults
```zsh
$ colorize_man rose-pine
$ man zsh
```

## Persisting customizations.
Any customization / exploration we have done is temporary. 

### Lazy way
One way to persist custom themes is to simply override settings in your `.zshrc`:
```zsh
$ vi ~/.zshrc
...
source ~/.config/zsh/rose-pine-man/rose-pine-man.zsh
MAN_THEME_TXT="255;128;237"
...
```

While the above works and is quick, we lose the ability to try out themes, and in some cases...could be problematic.

### Themeable way
Instead, let's copy `rose-pine-man.zsh` to somewhere else, so we can make changes to that secondary location, without having our updates overwritten by updates to the `rose-pine-man` github repository.  

Never fear--customizing login shell scripts is a time honored tradition!  So let's roll up our sleeves and get to it, and make _our_ theme, truly _yours_.

## Make and use local copy
```zsh
$ cp ~/.config/zsh/rose-pine-man/rose-pine-man.zsh ~/.config/zsh/custom-man.zsh
$ vi ~/.zshrc
...
# source ~/.config/zsh/rose-pine-man/rose-pine-man.zsh
source ~/.config/zsh/custom-man.zsh
colorize_man custom
...
$ . ~/.zshrc
```

If we ever need to revert back, comment the line containing `custom-man.zsh` and uncomment `rose-pine-man.zsh`.


## Applying custom colors
Locations intended for us to customize have been identified by a `CUSTOMIZE-FOR-YOU` token.  For custom colors, there are two steps:
1. Add your custom color
2. Apply your custom color to the custom theme

### Add custom color
The first step is to add custom colors..look for the second `CUSTOMIZE-FOR-YOU` token, and add your own colors!
```zsh
$ vi ~/.config/zsh/custom-man.zsh
...
##
# CUSTOMIZE-FOR-YOU
# suggest prefixing with my_<color name> but...you do you!
my_hot_pink="255;128;237"
my_color_name_1="<r>;<g>;<b>"
my_color_name_2="<r>;<g>;<b>"
my_color_name_3="<r>;<g>;<b>"
...
```

### Apply custom color
Now let's add our new custom colors to the custom theme.  Look for the first `CUSTOMIZE-FOR-YOU` token, and update with your desired color combination!
```zsh
...
##
# CUSTOMIZE-FOR-YOU
#   Modify the below with your own colors!
#   Suggest using variables, but feel free to use <var>="r;g;b"...you do you!
"custom")
  export MAN_THEME_BG=$my_color_name
  export MAN_THEME_TXT=$my_hot_pink
  export MAN_THEME_BG2=$rose_pine_highlight_med
  export MAN_THEME_UNDERLINE=$my_other_color_name
  export MAN_THEME_BOLD=$rose_pine_iris
  export MAN_THEME_BLINK=$rose_pine_love
  export MAN_THEME_REVERSE=$rose_pine_rose  
...
```

### Try custom theme out
Save, reload via `. ~/.zshrc`, and try it out! 

A common pattern is recommended to make edits in one terminal window or with one editor, and in another terminal window, reload and try out the changes!
```zsh
$ . ~/.zshrc
$ colorize_man custom      #just in case we missed a step...
$ term16m_man_color_test
$ man ls
```

## Update default theme
We have put good work into our custom theme, so let's update `custom-man.zsh` to use our custom theme by default. Doing so will also make your `.zshrc` process a tiny bit faster.  

Using the editor of your choice...

Change **from:**
```zsh
function colorize_man() {
  local theme="rose-pine" #default
  ...
```
**To:**
```zsh
function colorize_man() {
  local theme="custom" #default
  ...
```

Update your `.zshrc`...no need to specify custom!  
```zsh
...
# source ~/.config/zsh/rose-pine-man/rose-pine-man.zsh
source ~/.config/zsh/custom-man.zsh
...
```

Remember to reload your `.zshrc`:
```zsh
$ . ~/.zshrc
$ term16m_man_color_test
$ man ls
```

## Create new themes
To apply new themes...this part is not so elegant and...may change in the future! But, for the adventurous...read on!

First, decide on a theme name; remember, kebab-case looks nice!  From here:
* Next, we will add our theme name such that `colorize_man` recognizes the parameter.
* Next, add your theme _to_ `colorize_man`
* Finally, add your theme to `term16m_man_theme_color_test`


### Add your new theme to the list of recognized themes
```zsh
...
 case "${theme_input}" in
      ...
      "my-theme-name") theme=${theme_input}
      ;;
      ...
...
```

### Add your theme 
```zsh
...
    "my-theme-name")
      export MAN_THEME_BG=$color1
      export MAN_THEME_TXT=$color2
      export MAN_THEME_BG2=$color3
      export MAN_THEME_UNDERLINE=$color4
      export MAN_THEME_BOLD=$color5
      export MAN_THEME_BLINK=$color6
      export MAN_THEME_REVERSE=$color7
    ;;
...
```

### Add your theme `term16m_man_theme_color_test()`
```zsh
function term16m_man_theme_color_test() {
  ...
   term16m_man_theme_test my-theme-name
  ...
```

### Test out your theme
Remember to reload your `.zshrc`:
```zsh
$ . ~/.zshrc
$ color_man my-theme-name
$ term16m_man_color_test
$ man ls
```

# How it works
`man` colors are applied via the `less` pager.  For whatever reason, the `less` pager has _undocumented_ environment variables that apply arbitrary text strings (that we have chosen to render true-color enabled ANSI terminal tokens) to different bits and pieces of the source man documents. 

Note that  environment variable names are case sensitive!

| Less environment variable | Function              |
| ------------------------- | --------------------- |
| LESS_TERMCAP_md           | Activate bold         |
| LESS_TERMCAP_mb           | Activate blink        |
| LESS_TERMCAP_me           | Inactivate bold/blink |
| LESS_TERMCAP_so           | Activate stand-out    |
| LESS_TERMCAP_se           | Inactivate stand-out  |
| LESS_TERMCAP_us           | Activate underline    |
| LESS_TERMCAP_ue           | Inactivate underline  |

Note that setting a global `export LESS_TERMCAP_md` can negatively impact other colorization functions that feed text through `less` -  for ex, `chroma` / `pygments` etc can render askew.  

Instead of setting these environment variables globally, we use the `zsh` builtin `env` - this allows us to pass in an array of settings that apply once, to a _specific_ command, and protect the global less environment from our `man` color shenanigans.

We bundle all of the above in a  `function man()`...this way, we have better control over how the actual `man` command executes...including the ability to set a different default background/foreground text value!

# To-Dos
* Document how to use beyond `man`
* Theme check / application is inelegant - load from `~/.config/zsh/theme`
* Confirm linux compatibility
* Confirm `bash` compatibility 
