# alabaster-mocha.kak

# Palette
declare-option str rosewater 'rgb:f5e0dc'
declare-option str mauve 'rgb:cba6f7'
declare-option str red 'rgb:f38ba8'
declare-option str peach 'rgb:fab387'
declare-option str yellow 'rgb:f9e2af'
declare-option str green 'rgb:a6e3a1'
declare-option str blue 'rgb:89b4fa'
declare-option str lavender 'rgb:b4befe'

declare-option str text 'rgb:cdd6f4'
declare-option str subtext1 'rgb:bac2de'
declare-option str overlay2 'rgb:9399b2'
declare-option str surface1 'rgb:45475a'
declare-option str surface0 'rgb:313244'
declare-option str base 'rgb:1e1e2e'
declare-option str mantle 'rgb:181825'

declare-option str secondary_cursor 'rgb:b5a6a8'

# ----------------------------------------------------------------------
# Code
# ----------------------------------------------------------------------

set-face global attribute "%opt{text}"
set-face global builtin "%opt{text}"
set-face global comment "%opt{yellow}"
set-face global documentation comment
set-face global function "%opt{blue}"
set-face global identifier "%opt{text}"
set-face global keyword "%opt{text}"
set-face global meta "%opt{text}"
set-face global module "%opt{text}"
set-face global operator "%opt{overlay2}"
set-face global string "%opt{green}"
set-face global type "%opt{text}"
set-face global value "%opt{mauve}"
set-face global variable "%opt{text}"

# ----------------------------------------------------------------------
# Markup
# ----------------------------------------------------------------------

set-face global block "%opt{green}"
set-face global bullet "%opt{overlay2}"
set-face global header "%opt{blue}+b"
set-face global link "%opt{green}+u"
set-face global list "%opt{text}"
set-face global mono "%opt{green}"
set-face global title "%opt{blue}+b"

# ----------------------------------------------------------------------
# UI
# ----------------------------------------------------------------------

set-face global BufferPadding "%opt{base},%opt{base}"
set-face global Default "%opt{text},%opt{base}"
set-face global Error "%opt{red},%opt{surface0}+b"
set-face global Information "%opt{overlay2},%opt{surface0}"
set-face global LineNumberCursor "%opt{lavender},%opt{base}"
set-face global LineNumbers "%opt{surface1},%opt{base}"
set-face global LineNumbersWrapped "%opt{base},%opt{base}"
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

# ----------------------------------------------------------------------
# Diagnostics
# ----------------------------------------------------------------------

set-face global DiagnosticError "default,%opt{base},%opt{red}+c"
set-face global DiagnosticErrorCount "%opt{red},%opt{mantle}"
set-face global DiagnosticWarning "default,%opt{base},%opt{yellow}+c"
set-face global DiagnosticWarningCount "%opt{yellow},%opt{mantle}"
