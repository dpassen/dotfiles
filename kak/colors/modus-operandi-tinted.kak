# Modus-Operandi-Tinted theme for Kakoune

# Color palette
declare-option str bg_active 'rgb:c9b9b0'
declare-option str bg_alt 'rgb:c9b9b0'
declare-option str bg_dim 'rgb:efe9dd'
declare-option str bg_hl_line 'rgb:f1d5d0'
declare-option str bg_inactive 'rgb:dfd5cf'
declare-option str bg_main 'rgb:fbf7f0'
declare-option str bg_mode_line 'rgb:cab9b2'
declare-option str blue 'rgb:0031a9'
declare-option str blue_bright 'rgb:0000b0'
declare-option str blue_warmer 'rgb:3546c2'
declare-option str cursor 'rgb:000000'
declare-option str cyan 'rgb:00598b'
declare-option str cyan_cooler 'rgb:005f5f'
declare-option str cyan_warmer 'rgb:32548f'
declare-option str fg_alt 'rgb:193668'
declare-option str fg_dim 'rgb:595959'
declare-option str fg_main 'rgb:000000'
declare-option str fg_mode_line 'rgb:000000'
declare-option str fg_space 'rgb:9f9690'
declare-option str green 'rgb:006300'
declare-option str green_bright 'rgb:00603f'
declare-option str magenta_warmer 'rgb:8f0075'
declare-option str purple 'rgb:721045'
declare-option str purple_bright 'rgb:531ab6'
declare-option str red 'rgb:a60000'
declare-option str red_bright 'rgb:a0132f'
declare-option str yellow 'rgb:6d5000'
declare-option str yellow_bright 'rgb:602938'

declare-option str psel 'rgb:c2bcb5'
declare-option str ssel 'rgb:f1d5d0'

# For code
set-face global bracket 'rgb:7fdfcf'
set-face global builtin "%opt{magenta_warmer}"
set-face global comma "%opt{fg_main}"
set-face global comment 'rgb:7f0000'
set-face global constant "%opt{blue_bright}"
set-face global function "%opt{purple}"
set-face global keyword "%opt{purple_bright}"
set-face global meta "%opt{red_bright}"
set-face global module "%opt{fg_main}"
set-face global operator "%opt{fg_main}"
set-face global string "%opt{blue_warmer}"
set-face global type "%opt{cyan_cooler}"
set-face global value "%opt{fg_main}"
set-face global variable "%opt{cyan}"

# For markup
set-face global block "%opt{blue_bright}"
set-face global bold "%opt{purple}"
set-face global bullet "%opt{green}"
set-face global header "%opt{yellow_bright}"
set-face global italic "%opt{purple_bright}"
set-face global link "%opt{green}"
set-face global list "%opt{fg_main}"
set-face global mono "%opt{green}"
set-face global title "%opt{purple}"

# Builtin faces
set-face global BufferPadding "%opt{bg_main},%opt{bg_main}"
set-face global Default "%opt{fg_main},%opt{bg_main}"
set-face global DiagnosticError "%opt{fg_main},%opt{bg_main},%opt{red}+c"
set-face global DiagnosticErrorCount "%opt{red},%opt{bg_mode_line}"
set-face global DiagnosticWarning "%opt{fg_main},%opt{bg_main},%opt{yellow}+c"
set-face global DiagnosticWarningCount "%opt{yellow},%opt{bg_mode_line}"
set-face global Error "%opt{red},%opt{bg_mode_line}"
set-face global Information "%opt{fg_mode_line},%opt{bg_mode_line}"
set-face global LineNumberCursor "%opt{fg_alt},%opt{bg_main}+b"
set-face global LineNumbers "%opt{fg_dim},%opt{bg_main}"
set-face global LineNumbersWrapped "%opt{bg_dim},%opt{bg_main}+i"
set-face global MatchingChar "%opt{blue},%opt{bg_main}"
set-face global MenuBackground "%opt{fg_main},%opt{bg_alt}"
set-face global MenuForeground "%opt{bg_main},%opt{fg_main}+b"
set-face global MenuInfo "%opt{fg_alt},%opt{bg_alt}"
set-face global PrimaryCursor "%opt{bg_main},%opt{cursor}"
set-face global PrimaryCursorEol "%opt{bg_main},%opt{red_bright}"
set-face global PrimarySelection "default,%opt{psel}"
set-face global Prompt "%opt{fg_mode_line},%opt{bg_mode_line}"
set-face global SecondaryCursor "%opt{bg_main},%opt{fg_alt}"
set-face global SecondaryCursorEol "%opt{bg_main},%opt{blue}"
set-face global SecondarySelection "default,%opt{ssel}"
set-face global StatusCursor "%opt{fg_main},%opt{blue}"
set-face global StatusLine "%opt{fg_mode_line},%opt{bg_mode_line}"
set-face global StatusLineInfo "%opt{fg_mode_line},%opt{bg_mode_line}"
set-face global StatusLineMode "%opt{fg_mode_line},%opt{bg_mode_line}"
set-face global StatusLineValue "%opt{fg_mode_line},%opt{bg_mode_line}"
set-face global Whitespace "%opt{fg_space},%opt{bg_main}+f"
set-face global WrapMarker Whitespace
