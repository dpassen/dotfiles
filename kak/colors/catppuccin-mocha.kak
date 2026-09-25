# catppuccin-mocha.kak

# Palette
declare-option str rosewater 'rgb:f5e0dc'
declare-option str flamingo 'rgb:f2cdcd'
declare-option str pink 'rgb:f5c2e7'
declare-option str mauve 'rgb:cba6f7'
declare-option str red 'rgb:f38ba8'
declare-option str maroon 'rgb:eba0ac'
declare-option str peach 'rgb:fab387'
declare-option str yellow 'rgb:f9e2af'
declare-option str green 'rgb:a6e3a1'
declare-option str teal 'rgb:94e2d5'
declare-option str sky 'rgb:89dceb'
declare-option str sapphire 'rgb:74c7ec'
declare-option str blue 'rgb:89b4fa'
declare-option str lavender 'rgb:b4befe'

declare-option str text 'rgb:cdd6f4'
declare-option str subtext1 'rgb:bac2de'
declare-option str subtext0 'rgb:a6adc8'
declare-option str overlay2 'rgb:9399b2'
declare-option str overlay1 'rgb:7f849c'
declare-option str overlay0 'rgb:6c7086'
declare-option str surface2 'rgb:585b70'
declare-option str surface1 'rgb:45475a'
declare-option str surface0 'rgb:313244'
declare-option str base 'rgb:1e1e2e'
declare-option str mantle 'rgb:181825'
declare-option str crust 'rgb:11111b'

declare-option str cursorline 'rgb:2a2b3c'
declare-option str secondary_cursor 'rgb:b5a6a8'

# ----------------------------------------------------------------------
# Code
# ----------------------------------------------------------------------

set-face global bracket "%opt{overlay2}"
set-face global builtin "%opt{mauve}"
set-face global comma "%opt{overlay2}"
set-face global comment "%opt{overlay2}+i"
set-face global constant "%opt{peach}"
set-face global function "%opt{blue}"
set-face global keyword "%opt{mauve}"
set-face global meta "%opt{rosewater}"
set-face global module "%opt{yellow}+i"
set-face global operator "%opt{sky}"
set-face global string "%opt{green}"
set-face global type "%opt{yellow}"
set-face global value "%opt{peach}"
set-face global variable "%opt{text}"

# ----------------------------------------------------------------------
# Markup
# ----------------------------------------------------------------------

set-face global block "%opt{green}"
set-face global bold "%opt{red}+b"
set-face global bullet "%opt{teal}"
set-face global header "%opt{peach}+b"
set-face global italic "%opt{red}+i"
set-face global link "%opt{blue}+iu"
set-face global list "%opt{teal}"
set-face global mono "%opt{green}"
set-face global title "%opt{red}+b"

# ----------------------------------------------------------------------
# UI
# ----------------------------------------------------------------------

set-face global BufferPadding "%opt{base},%opt{base}"
set-face global Default "%opt{text},%opt{base}"
set-face global Error "%opt{red},%opt{surface0}+b"
set-face global Information "%opt{overlay2},%opt{surface0}"
set-face global LineNumberCursor "%opt{lavender},%opt{base}"
set-face global LineNumbers "%opt{surface1},%opt{base}"
set-face global LineNumbersWrapped "%opt{surface0},%opt{base}+i"
set-face global MatchingChar "%opt{peach},%opt{base}+b"
set-face global MenuBackground "%opt{overlay2},%opt{surface0}"
set-face global MenuForeground "%opt{text},%opt{surface1}+b"
set-face global MenuInfo "%opt{overlay2},%opt{surface0}"
set-face global PrimaryCursor "%opt{base},%opt{rosewater}"
set-face global PrimaryCursorEol "%opt{base},%opt{rosewater}"
set-face global PrimarySelection "default,%opt{surface1}"
set-face global Prompt "%opt{text},%opt{surface0}"
set-face global SecondaryCursor "%opt{base},%opt{secondary_cursor}"
set-face global SecondaryCursorEol "%opt{base},%opt{secondary_cursor}"
set-face global SecondarySelection "default,%opt{surface1}"
set-face global StatusCursor "%opt{base},%opt{rosewater}"
set-face global StatusLine "%opt{subtext1},%opt{mantle}"
set-face global StatusLineInfo "%opt{subtext1},%opt{mantle}"
set-face global StatusLineMode "%opt{base},%opt{rosewater}+b"
set-face global StatusLineValue "%opt{blue},%opt{mantle}"
set-face global Whitespace "%opt{overlay0},%opt{base}+f"
set-face global WrapMarker Whitespace

# ----------------------------------------------------------------------
# Diagnostics
# ----------------------------------------------------------------------

set-face global DiagnosticError "%opt{text},%opt{base},%opt{red}+c"
set-face global DiagnosticErrorCount "%opt{red},%opt{mantle}"
set-face global DiagnosticWarning "%opt{text},%opt{base},%opt{yellow}+c"
set-face global DiagnosticWarningCount "%opt{yellow},%opt{mantle}"
