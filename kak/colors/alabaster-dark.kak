# alabaster-dark.kak

# Color palette
declare-option str fg 'rgb:cecece'
declare-option str bg 'rgb:0e1415'

# The four semantic colors
declare-option str string 'rgb:95cb82'
declare-option str constant 'rgb:cc8bc9'
declare-option str comment 'rgb:dfdf8e'
declare-option str definition 'rgb:71ade7'

# Supporting colors
declare-option str punctuation 'rgb:8c8c8c'
declare-option str selection 'rgb:1e3a5f'
declare-option str selection_primary 'rgb:4a7ba7'
declare-option str active 'rgb:cd974b'
declare-option str cursor_secondary 'rgb:7a5b30'
declare-option str highlight 'rgb:ff9800'
declare-option str error_red 'rgb:dfdf8e'
declare-option str panel 'rgb:252526'
declare-option str bg_hl_line 'rgb:141819'
declare-option str bg_hl_line_primary 'rgb:1a2022'

# Code
set-face global bracket "%opt{punctuation}"
set-face global builtin "%opt{fg}"
set-face global comma "%opt{punctuation}"
set-face global comment "%opt{comment}"
set-face global constant "%opt{constant}"
set-face global function "%opt{definition}"
set-face global keyword "%opt{fg}"
set-face global meta "%opt{fg}"
set-face global module "%opt{fg}"
set-face global operator "%opt{punctuation}"
set-face global string "%opt{string}"
set-face global type "%opt{fg}"
set-face global value "%opt{constant}"
set-face global variable "%opt{fg}"

# For markup
set-face global title "%opt{definition}+b"
set-face global header "%opt{definition}+b"
set-face global bold "default+b"
set-face global italic "default+i"
set-face global mono "%opt{string}"
set-face global block "%opt{string}"
set-face global link "%opt{string}+u"
set-face global bullet "%opt{punctuation}"
set-face global list "%opt{fg}"

# Builtin faces
set-face global Default "%opt{fg},%opt{bg}"
set-face global PrimarySelection "default,%opt{selection_primary}"
set-face global SecondarySelection "default,%opt{selection}"
set-face global PrimaryCursor "%opt{bg},%opt{active}"
set-face global SecondaryCursor "%opt{bg},%opt{cursor_secondary}"
set-face global PrimaryCursorEol "%opt{bg},%opt{active}"
set-face global SecondaryCursorEol "%opt{bg},%opt{cursor_secondary}"
set-face global LineNumbers "%opt{punctuation},%opt{bg}"
set-face global LineNumberCursor "%opt{active},%opt{bg}+b"
set-face global LineNumbersWrapped "%opt{bg},%opt{bg}+i"
set-face global MenuForeground "%opt{bg},%opt{active}+b"
set-face global MenuBackground "%opt{fg},%opt{panel}"
set-face global MenuInfo "%opt{punctuation},%opt{panel}"
set-face global Information "%opt{fg},%opt{panel}"
set-face global Error "%opt{error_red},%opt{panel}+b"
set-face global StatusLine "%opt{fg},%opt{panel}"
set-face global StatusLineMode "%opt{active},%opt{panel}+b"
set-face global StatusLineInfo "%opt{fg},%opt{panel}"
set-face global StatusLineValue "%opt{definition},%opt{panel}"
set-face global StatusCursor "%opt{bg},%opt{active}"
set-face global Prompt "%opt{fg},%opt{panel}"
set-face global MatchingChar "%opt{active},%opt{bg}+u"
set-face global Whitespace "%opt{punctuation},%opt{bg}+f"
set-face global WrapMarker Whitespace
set-face global BufferPadding "%opt{bg},%opt{bg}"
set-face global DiagnosticError "%opt{fg},%opt{bg},%opt{error_red}+c"
set-face global DiagnosticWarning "%opt{fg},%opt{bg},%opt{highlight}+c"
set-face global DiagnosticErrorCount "%opt{error_red},%opt{panel}"
set-face global DiagnosticWarningCount "%opt{highlight},%opt{panel}"
