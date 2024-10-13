
# rose-pine-man.zh
# (C) 2024 const void* 
# https://github.com/const-void/rose-pine-man.git
#
# README.md has details!

# Quick installation
#
# Add to ~/.zshrc:
#   source ~/.config/zsh/rose-pine-man/rose-pine-man.zsh #or wherever we cloned this repo
#   # colorize_man "rose-pine"                # "rose-pine-moon", "rose-pine-dawn", "custom"
#   # colorize_man "rose-pine" "transparent"  # second parameter is optional - set to transparent 
#                                             # or true to activate transparency

# To customize, search on CUSTOMIZE-FOR-YOU.  Minimal changes are needed. Have fun!

# $ colorize_man <theme> [true]
function colorize_man() {
  local theme="rose-pine" #default

  #confirm input theme - if unrecognized, use default (rose-pine)
  if [[ "${#}" -ne 0 ]]; then
    local theme_input=$1
    typeset -l theme_input

    case "${theme_input}" in
      "rose-pine-moon") theme=${theme_input}
      ;;
      "rose-pine-dawn") theme=${theme_input}
      ;;
      "custom") theme=${theme_input}
      ;;
    esac
    # otherwise, $theme is unchanged + remains default

    #default is a solid background - set transparency to OFF
    export MAN_TRANSPARENCY=0
    if [[ "${#}" -ge 2 ]]; then
      local transparency_input=$2
      typeset -l transparency_input

      if [[ "${transparency_input}" == "transparent" || "${transparency_input}" == "true" ]]; then
        #activate transparency logic
        export MAN_TRANSPARENCY=1
      fi
    fi
  fi



  # apply colors to exported theme env vars
  case "${theme}" in
    "rose-pine")
      export MAN_THEME_BG=$rose_pine_base
      export MAN_THEME_TXT=$rose_pine_text
      export MAN_THEME_BG2=$rose_pine_highlight_low
      export MAN_THEME_UNDERLINE=$rose_pine_gold
      export MAN_THEME_BOLD=$rose_pine_iris
      export MAN_THEME_BLINK=$rose_pine_love
      export MAN_THEME_REVERSE=$rose_pine_rose
    ;;
    "rose-pine-moon")
      export MAN_THEME_BG=$rose_pine_moon_base
      export MAN_THEME_TXT=$rose_pine_moon_text
      export MAN_THEME_BG2=$rose_pine_moon_highlight_low
      export MAN_THEME_UNDERLINE=$rose_pine_moon_gold
      export MAN_THEME_BOLD=$rose_pine_moon_iris
      export MAN_THEME_BLINK=$rose_pine_moon_love
      export MAN_THEME_REVERSE=$rose_pine_moon_rose
    ;;
    "rose-pine-dawn")
      export MAN_THEME_BG=$rose_pine_dawn_base
      export MAN_THEME_TXT=$rose_pine_dawn_text
      export MAN_THEME_BG2=$rose_pine_dawn_surface
      export MAN_THEME_UNDERLINE=$rose_pine_dawn_gold
      export MAN_THEME_BOLD=$rose_pine_dawn_iris
      export MAN_THEME_BLINK=$rose_pine_dawn_love
      export MAN_THEME_REVERSE=$rose_pine_dawn_rose
    ;;
    ##
    # CUSTOMIZE-FOR-YOU
    #   Modify the below with your own colors!
    #   Suggest using variables, but feel free to use <var>="r;g;b"...you do you!
    "custom")
      export MAN_THEME_BG=$rose_pine_base
      export MAN_THEME_TXT=$my_hot_pink
      export MAN_THEME_BG2=$rose_pine_highlight_med
      export MAN_THEME_UNDERLINE=$rose_pine_gold
      export MAN_THEME_BOLD=$rose_pine_iris
      export MAN_THEME_BLINK=$rose_pine_love
      export MAN_THEME_REVERSE=$rose_pine_rose  
  esac
}

### COLORS ###############################################

##
# CUSTOMIZE-FOR-YOU
# suggest prefixing with my_<color name> but...you do you!
my_hot_pink="255;128;237"
#
##

## https://rosepinetheme.com/palette/ingredients/
# Rose Pine
rose_pine_base="25;23;36"
rose_pine_surface="32;29;46"
rose_pine_overlay="38;35;58"
rose_pine_muted="110;106;134"
rose_pine_subtle="144;140;170"
rose_pine_text="224;222;244"
rose_pine_love="235;111;146"
rose_pine_gold="246;193;119"
rose_pine_rose="235;188;186"
rose_pine_pine="49;116;143"
rose_pine_foam="156;207;216"
rose_pine_iris="196;167;231"
rose_pine_highlight_low="33;32;36"
rose_pine_highlight_med="64;61;82"
rose_pine_highlight_high="82;79;103"

# Rose Pine Moon
rose_pine_moon_base="35;33;54"
rose_pine_moon_surface="42;39;63"
rose_pine_moon_overlay="57;53;82"
rose_pine_moon_muted="110;106;134"
rose_pine_moon_subtle="144;140;170"
rose_pine_moon_text="224;222;244"
rose_pine_moon_love="235;111;146"
rose_pine_moon_gold="246;193;119"
rose_pine_moon_rose="234;154;151"
rose_pine_moon_pine="62;143;176"
rose_pine_moon_foam="156;207;216"
rose_pine_moon_iris="196;167;231"
rose_pine_moon_highlight_low="42;40;62"
rose_pine_moon_highlight_med="68;65;90"
rose_pine_moon_highlight_high="86;82;110"

# Rose Pine Dawn
rose_pine_dawn_base="250;244;237"
rose_pine_dawn_surface="255;250;243"
rose_pine_dawn_overlay="242;233;222"
rose_pine_dawn_muted="152;147;165"
rose_pine_dawn_subtle="121;117;147"
rose_pine_dawn_text="87;82;121"
rose_pine_dawn_love="180;99;122"
rose_pine_dawn_gold="234;157;52"
rose_pine_dawn_rose="215;130;126"
rose_pine_dawn_pine="40;105;131"
rose_pine_dawn_foam="86;148;159"
rose_pine_dawn_iris="144;122;169"
rose_pine_dawn_highlight_low="244;237;232"
rose_pine_dawn_highlight_med="223;218;217"
rose_pine_dawn_highlight_high="206;202;205"

## truecolore ansi token helpers
term16m_bgn='\033['
term16m_end='m'
term16m_bg='48;2;'
term16m_fg='38;2;'
term16m_reset="${term16m_bgn}0${term16m_end}"

## Helper functions #########################

## Given background r;g;b and foreground r;g;b, create truecolor ANSI terminal token
## 
## If global MAN_TRANSPARENCY, do not set background colors"
## 
# $ term16m_set_less_color 
# $ term16m_set_less_color <bg r;g;b> <fg r;g;b>
function term16m_set_less_color() {
  if [[ "${MAN_TRANSPARENCY}" -eq 0 ]]; then 
    echo "${term16m_bgn}${term16m_bg}$1;${term16m_fg}$2${term16m_end}"
  else
    echo "${term16m_bgn};${term16m_fg}$2${term16m_end}"
  fi
}

# man <man page>
function man() {
  local normal=$(term16m_set_less_color $MAN_THEME_BG $MAN_THEME_TXT)
  local -a environment
  environment+=("LESS_TERMCAP_md=$(term16m_set_less_color $MAN_THEME_BG2 $MAN_THEME_BOLD)")       #begin bold
  environment+=("LESS_TERMCAP_mb=$(term16m_set_less_color $MAN_THEME_BG2 $MAN_THEME_BLINK)")      #begin blink
  environment+=("LESS_TERMCAP_me=$normal")                                                        #end bold/blink

  environment+=("LESS_TERMCAP_so=$(term16m_set_less_color $MAN_THEME_BG2 $MAN_THEME_REVERSE)")    #begin standout/reverse
  environment+=("LESS_TERMCAP_se=$normal")                                                        #end standout/reverse

  environment+=("LESS_TERMCAP_us=$(term16m_set_less_color $MAN_THEME_BG2 $MAN_THEME_UNDERLINE)")  #begin underline
  environment+=("LESS_TERMCAP_ue=$normal")                                                        #end underline

  echo -en "${normal}"
  command env $environment man "$@"
}

### More Helper Functions ##########################

## Render current man theme colors
# $ term16m_man_color_test
function term16m_man_color_test() {
  local normal=$(term16m_set_less_color $MAN_THEME_BG $MAN_THEME_TXT)
  echo "$(term16m_set_less_color $MAN_THEME_BG2 $MAN_THEME_BOLD)BOLD_TEST${term16m_reset}"
  echo "$(term16m_set_less_color $MAN_THEME_BG2 $MAN_THEME_UNDERLINE)UNDERLINE${term16m_reset}"
  echo "$(term16m_set_less_color $MAN_THEME_BG2 $MAN_THEME_BLINK)BLINK${term16m_reset}"
  echo "$(term16m_set_less_color $MAN_THEME_BG2 $MAN_THEME_REVERSE)REVERSE${term16m_reset}"
  echo "${normal}NORMAL TEXT${term16m_reset}"
}

## Render one theme
# $ term16m_man_theme_test <theme-name>
function term16m_man_theme_test() {
  echo "[ $1 ]"
  colorize_man $1
  term16m_man_color_test
  echo ""
}

## Render all themes
# $ term16m_man_theme_color_test
function term16m_man_theme_color_test() {
  echo "colorized man theme test:"
  echo ""
  term16m_man_theme_test rose-pine
  term16m_man_theme_test rose-pine-moon
  term16m_man_theme_test rose-pine-moon
  term16m_man_theme_test rose-pine-dawn
  term16m_man_theme_test custom

  #reset to default
  colorize_man
}

## Simple hexdecimal to integer helper funciton
# $ hex_to_int FF
# 255
#
# $ hex_to_int '<hex-value>'
function hex_to_int() {
  echo $((16#$1))
}

## Hex to ANSI RGB 
# $ term16m_hex_to_ansi_rgb '#c4a7e7'
# 196;167;231
# $ term16m_hex_to_ansi_rgb 'c4a7e7'
# 196;167;231
#
# $ term16m_hex_to_ansi_rgb '<#hex-color>'
function term16m_hex_to_ansi_rgb() {
  local rgb=$1
  typeset -u rgb

  # strip leading # in #c4a7e7
  local rgb_first_char=${rgb:0:1}
  if [[ rgb_first_char -eq '#' ]]; then
    rgb=${rgb:1}
  fi

  #Clear:
  #
  #local r_hex=${rgb:0:2}
  #local g_hex=${rgb:2:2}
  #local b_hex=${rgb:4:2}
  #
  #local r_int=$(hex_to_int $r_hex)
  #local g_int=$(hex_to_int $g_hex)
  #local b_int=$(hex_to_int $b_hex)  
  #
  #echo "${r_int};${g_int};${b_int}"

  #Complex:
  echo "$((16#${rgb:0:2}));$((16#${rgb:2:2}));$((16#${rgb:4:2}))"
}

## Convert (r,g,b) to r;g;b, validating input
# $ term16m_rgb_to_ansi_rgb 204 14 203
#
# $ term16m_rgb_to_ansi_rgb <r> <g> <b>
function term16m_rgb_to_ansi_rgb() {
  if [[ "${#}" -ne 3 ]]; then #abort with black
    echo "0;0;0"
    return
  fi

  #convert to int
  local r=$(($1))
  local g=$(($2))
  local b=$(($3))

  #clamp to 0...255
  if [[ "${r}" -lt 0 || "${r}" -gt 255 ]]; then
    r=0
  fi

  if [[ "${g}" -lt 0 || "${g}" -gt 255 ]]; then
    g=0
  fi

  if [[ "${b}" -lt 0 || "${b}" -gt 255 ]]; then
    b=0
  fi

  echo "$r;$g;$b"
}

colorize_man