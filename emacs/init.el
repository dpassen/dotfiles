;;; init.el --- Initialization code ;;; -*- lexical-binding: t;-*-
;;; Commentary:

;;; Code:

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(setopt use-package-always-defer t
        use-package-hook-name-suffix nil
        use-package-vc-prefer-newest t)

(use-package use-package-treesit
  :ensure t
  :demand t)

(use-package emacs
  :custom
  (frame-resize-pixelwise t)
  (indent-tabs-mode nil)
  (inhibit-startup-screen t)
  (initial-scratch-message ";;; -*- lexical-binding: t;-*-\n\n;; rebellious pro\n\n")
  (ring-bell-function 'ignore)
  (use-short-answers t)
  :init
  (setq frame-title-format "%b\n"
        kill-buffer-query-functions nil
        load-prefer-newer t
        message-truncate-lines t
        read-process-output-max (* 1024 1024)))

(use-package apheleia
  :ensure t
  :hook (after-init-hook . apheleia-global-mode))

(use-package auto-dark
  :ensure t
  :when (display-graphic-p)
  :custom (auto-dark-themes '((ef-dark) (ef-light)))
  :hook after-init-hook)

(use-package autorevert
  :custom (auto-revert-verbose nil)
  :hook (after-init-hook .  global-auto-revert-mode))

(use-package bash-ts-mode
  :treesit)

(use-package c++-ts-mode
  :treesit)

(use-package c-ts-mode
  :treesit)

(use-package cape
  :ensure t
  :bind-keymap ("C-c p" . cape-prefix-map))

(use-package cider
  :ensure t
  :custom
  (cider-connection-message-fn nil)
  (cider-download-java-sources t)
  (cider-font-lock-dynamically nil)
  (cider-ns-save-files-on-refresh t)
  (cider-repl-display-help-banner nil)
  (cider-repl-history-file 'per-project)
  (cider-repl-pop-to-buffer-on-connect nil)
  (cider-save-file-on-load t)
  (cider-use-fringe-indicators nil))

(use-package clojure-mode
  :custom
  (clojure-align-forms-automatically t)
  (clojure-toplevel-inside-comment-form t))

(use-package comp
  :custom
  (native-comp-async-report-warnings-errors nil))

(use-package consult
  :ensure t
  :custom
  (xref-show-definitions-function #'consult-xref)
  (xref-show-xrefs-function #'consult-xref)
  :bind (("M-y" . consult-yank-pop)
         :map ctl-x-map ("b" . consult-buffer)
         :map goto-map
         ("M-g" . consult-goto-line)
         ("f" . consult-flymake)
         ("g" . consult-goto-line)
         ("i" . consult-imenu)
         :map search-map
         ("l" . consult-line)
         ("r" . consult-ripgrep)))

(use-package corfu
  :ensure t
  :custom (corfu-cycle t)
  :hook (after-init-hook . global-corfu-mode))

(use-package css-ts-mode
  :treesit)

(use-package custom
  :custom (custom-file (locate-user-emacs-file "custom.el"))
  :config
  (load custom-file :no-error-if-file-is-missing)
  (add-hook 'enable-theme-functions
            (lambda (&rest _)
              (set-face-attribute 'bold nil :weight 'semibold))))

(use-package dired
  :custom
  (dired-kill-when-opening-new-dired-buffer t)
  (dired-use-ls-dired nil))

(use-package dired-gitignore
  :ensure t
  :hook dired-mode-hook)

(use-package diredfl
  :ensure t
  :hook dired-mode-hook)

(use-package display-line-numbers
  :custom (display-line-numbers-width-start t)
  :hook (conf-mode-hook prog-mode-hook text-mode-hook))

(use-package disproject
  :ensure t
  :custom
  (disproject-find-line-command #'consult-line-multi)
  (disproject-shell-command #'terminal-here)
  (disproject-switch-to-buffer-command #'consult-project-buffer)
  :bind (:map ctl-x-map ("p" . disproject-dispatch)))

(use-package doom-modeline
  :ensure t
  :custom
  (doom-modeline-bar-width 0.1)
  (doom-modeline-buffer-file-name-style 'relative-to-project)
  (doom-modeline-buffer-encoding nil)
  (doom-modeline-buffer-state-icon nil)
  (doom-modeline-check 'simple)
  (doom-modeline-column-zero-based nil)
  (doom-modeline-env-version nil)
  (doom-modeline-major-mode-icon nil)
  (doom-modeline-percent-position nil)
  :config (doom-modeline-remove-segment 'vcs)
  :hook after-init-hook)

(use-package dumb-jump
  :ensure t
  :custom
  (dumb-jump-prefer-searcher 'rg)
  (dumb-jump-selector 'completing-read)
  :hook (xref-backend-functions . dumb-jump-xref-activate))

(use-package edit-indirect
  :ensure t)

(use-package editorconfig
  :hook after-init-hook)

(use-package ef-themes
  :ensure t)

(use-package eglot
  :custom
  (eglot-autoshutdown t)
  (eglot-confirm-server-edits nil)
  (eglot-ignored-server-capabilities
   '(:documentHighlightProvider
     :documentOnTypeFormattingProvider
     :inlayHintProvider))
  (eglot-sync-connect nil)
  :bind (:map eglot-mode-map
              ("C-c l a" . eglot-code-actions)
              ("C-c l f b" . eglot-format-buffer)
              ("C-c l f f" . eglot-format)
              ("C-c l r" . eglot-rename)))

(use-package eldoc-box
  :ensure t
  :custom (eldoc-box-clear-with-C-g t)
  :bind ("C-c k" . eldoc-box-help-at-point))

(use-package embark
  :ensure t
  :bind ("C-." . embark-act)
  :init (setq prefix-help-command 'embark-prefix-help-command))

(use-package embark-consult
  :ensure t
  :hook (embark-collect-mode-hook . consult-preview-at-point-mode))

(use-package eros
  :ensure t
  :hook lisp-data-mode-hook)

(use-package expand-region
  :ensure t
  :custom (expand-region-show-usage-message nil)
  :bind ("C-=" . er/expand-region))

(use-package faces
  :when (display-graphic-p)
  :config
  (dolist (face '(default tooltip))
    (set-face-attribute face nil :font "Berkeley Mono Variable 12")))

(use-package files
  :custom
  (confirm-kill-processes nil)
  (major-mode-remap-alist
   '((c++-mode . c++-ts-mode)
     (c-mode . c-ts-mode)
     (conf-toml-mode . toml-ts-mode)
     (css-mode . css-ts-mode)
     (java-mode . java-ts-mode)
     (javascript-mode . js-ts-mode)
     (js-json-mode . json-ts-mode)
     (mhtml-mode . html-ts-mode)
     (python-mode . python-ts-mode)
     (ruby-mode . ruby-ts-mode)
     (sh-mode . bash-ts-mode)))
  (require-final-newline t))

(use-package fish-mode
  :ensure t)

(use-package flymake
  :custom
  (flymake-fringe-indicator-position nil)
  (flymake-margin-indicator-position nil)
  :hook prog-mode-hook)

(use-package flymake-kondor
  :ensure t
  :hook (clojure-mode-hook . flymake-kondor-setup))

(use-package flyover
  :ensure t
  :custom
  (flyover-base-height 1)
  (flyover-checkers '(flymake))
  (flyover-display-mode 'show-only-on-same-line)
  (flyover-show-icon nil)
  (flyover-text-tint-percent 75)
  (flyover-virtual-line-type 'line-no-arrow)
  :hook flymake-mode-hook)

(use-package frame
  :when (display-graphic-p)
  :config
  (dolist (frame-parameters '((height . 40) (width . 96)))
    (push frame-parameters default-frame-alist)))

(use-package git-link
  :ensure t
  :custom (git-link-use-commit t))

(use-package git-modes
  :ensure t)

(use-package git-timemachine
  :ensure t)

(use-package grep
  :custom (grep-use-headings t))

(use-package help
  :custom (help-window-select t))

(use-package hideshow
  :hook (prog-mode-hook . hs-minor-mode))

(use-package hl-todo
  :ensure t
  :hook (after-init-hook . global-hl-todo-mode))

(use-package html-ts-mode
  :treesit)

(use-package java-ts-mode
  :treesit)

(use-package js-ts-mode
  :treesit)

(use-package json-ts-mode
  :treesit)

(use-package just-mode
  :ensure t)

(use-package kotlin-ts-mode
  :ensure t
  :mode "\\.kts?\\'"
  :treesit)

(use-package marginalia
  :ensure t
  :hook after-init-hook)

(use-package markdown-mode
  :ensure t
  :custom (markdown-fontify-code-blocks-natively t))

(use-package misc
  :bind ("M-z" . zap-up-to-char))

(use-package modus-themes
  :custom
  (modus-themes-bold-constructs t)
  (modus-themes-common-palette-overrides
   '((bg-line-number-active unspecified)
     (bg-line-number-inactive unspecified)
     (bg-mode-line-active bg-alt)
     (fg-line-number-active fg-main)
     (fg-line-number-inactive "gray50")))
  (modus-themes-italic-constructs t))

(use-package nerd-icons-completion
  :ensure t
  :hook (marginalia-mode-hook . nerd-icons-completion-marginalia-setup))

(use-package nerd-icons-corfu
  :ensure t
  :hook (corfu-margin-formatters . nerd-icons-corfu-formatter))

(use-package nerd-icons-dired
  :ensure t
  :hook dired-mode-hook)

(use-package nerd-icons-grep
  :ensure t
  :hook grep-mode-hook)

(use-package nerd-icons-xref
  :ensure t
  :hook after-init-hook)

(use-package nucleo-completion
  :ensure t
  :custom
  (completion-category-defaults nil)
  (completion-styles '(nucleo basic))
  (nucleo-completion-module-install-policy 'prompt)
  (nucleo-completion-sort-ties-by-length t)
  :init (nucleo-completion-ensure-module))

(use-package paren
  :custom (show-paren-mode nil))

(use-package paren-face
  :ensure t
  :custom (paren-face-regexp "#?[](){}[]")
  :hook (elpaca-after-init-hook . global-paren-face-mode))

(use-package project
  :config
  (push '(major-mode . cider-repl-mode) project-kill-buffer-conditions))

(use-package pulse
  :custom (pulse-flag 'never))

(use-package python-ts-mode
  :treesit)

(use-package ruby-ts-mode
  :treesit)

(use-package rust-ts-mode
  :mode "\\.rs\\'"
  :treesit)

(use-package simple
  :custom
  (async-shell-command-buffer 'new-buffer)
  (column-number-mode t)
  (kill-do-not-save-duplicates t)
  (read-extended-command-predicate 'command-completion-default-include-p)
  (read-quoted-char-radix 16)
  (save-interprogram-paste-before-kill t))

(use-package smartparens
  :ensure t
  :custom (sp-highlight-pair-overlay nil)
  :config
  (require 'smartparens-config)
  (sp-use-smartparens-bindings)
  :hook prog-mode-hook
  ((cider-repl-mode-hook
    clojure-mode-hook
    eval-expression-minibuffer-setup-hook
    lisp-data-mode-hook) . smartparens-strict-mode))

(use-package stillness-mode
  :ensure t
  :hook after-init-hook)

(use-package subword
  :hook (after-init-hook . global-subword-mode))

(use-package terminal-here
  :vc (:url "https://github.com/dpassen/terminal-here")
  :custom (terminal-here-terminal-command 'ghostty))

(use-package toml-ts-mode
  :treesit)

(use-package transient
  :ensure t
  :custom (transient-mode-line-format nil))

(use-package treesit
  :custom (treesit-font-lock-level 2))

(use-package tsx-ts-mode
  :mode "\\.tsx\\'"
  :treesit)

(use-package typescript-ts-mode
  :mode "\\.ts\\'"
  :treesit)

(use-package typst-mode
  :mode "\\.typ\\(st\\)?\\'"
  :vc (:url "https://git.sr.ht/~meow_king/typst-mode"))

(use-package uniquify
  :custom (uniquify-buffer-name-style 'forward))

(use-package vc-jj
  :ensure t
  :demand t
  :after vc)

(use-package vertico
  :ensure t
  :custom
  (vertico-count-format nil)
  (vertico-cycle t)
  (vertico-multiform-commands
   '((execute-extended-command reverse)
     (execute-extended-command-for-buffer reverse)))
  (vertico-resize nil)
  :config (vertico-multiform-mode 1)
  :hook after-init-hook)

(use-package wgrep
  :ensure t
  :custom (wgrep-auto-save-buffer t))

(use-package xref
  :custom
  (xref-history-storage 'xref-window-local-history)
  (xref-search-program 'ripgrep))

(use-package yaml-mode
  :ensure t)

(use-package mise
  :ensure t
  :hook (after-init-hook . global-mise-mode))

(use-package exec-path-from-shell
  :ensure t
  :when (memq window-system '(mac ns x))
  :hook (after-init-hook . exec-path-from-shell-initialize))

;; Local Variables:
;; no-byte-compile: t
;; no-native-compile: t
;; no-update-autoloads: t
;; End:

;;; init.el ends here
