;;; init.el --- Initialization code ;;; -*- lexical-binding: t;-*-
;;; Commentary:

;;; Code:

(setopt custom-file (locate-user-emacs-file "custom.el"))
(load custom-file :no-error-if-file-is-missing)

(defvar elpaca-installer-version 0.11)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil :depth 1 :inherit ignore
                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                              :build (:not elpaca--activate-package)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (condition-case-unless-debug err
        (if-let* ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                  ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                  ,@(when-let* ((depth (plist-get order :depth)))
                                                      (list (format "--depth=%d" depth) "--no-single-branch"))
                                                  ,(plist-get order :repo) ,repo))))
                  ((zerop (call-process "git" nil buffer t "checkout"
                                        (or (plist-get order :ref) "--"))))
                  (emacs (concat invocation-directory invocation-name))
                  ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                        "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                  ((require 'elpaca))
                  ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (let ((load-source-file-function nil)) (load "./elpaca-autoloads"))))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

(elpaca elpaca-use-package
  (elpaca-use-package-mode)
  (setopt use-package-always-defer t
          use-package-hook-name-suffix nil))

(use-package general
  :ensure (:wait t)
  :demand t)

(use-package use-package-treesit
  :ensure (:wait t)
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
  :hook (elpaca-after-init-hook . apheleia-global-mode))

(use-package auto-dark
  :ensure t
  :custom (auto-dark-themes '((ef-dark) (ef-light)))
  :hook elpaca-after-init-hook)

(use-package autorevert
  :custom (auto-revert-verbose nil)
  :hook (elpaca-after-init-hook .  global-auto-revert-mode))

(use-package bash-ts-mode
  :treesit)

(use-package c-ts-mode
  :treesit)

(use-package c++-ts-mode
  :treesit)

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

(use-package clojure-ts-mode
  :ensure t
  :treesit
  :custom
  (clojure-ts-align-forms-automatically t)
  (clojure-ts-toplevel-inside-comment-form t))

(use-package comp
  :custom
  (native-comp-async-report-warnings-errors nil))

(use-package completion-preview
  :custom (completion-preview-message-format nil)
  :general
  (completion-preview-active-mode-map
   "M-n" 'completion-preview-next-candidate
   "M-p" 'completion-preview-prev-candidate)
  :hook (conf-mode-hook prog-mode-hook))

(use-package consult
  :ensure t
  :custom
  (xref-show-definitions-function #'consult-xref)
  (xref-show-xrefs-function #'consult-xref)
  :general
  (ctl-x-map "b" 'consult-buffer)
  (:prefix "M-g"
           "M-g" 'consult-goto-line
           "g" 'consult-goto-line
           "i" 'consult-imenu)
  (:prefix "M-s"
           "l" 'consult-line
           "r" 'consult-ripgrep)
  ("M-y" 'consult-yank-pop))

(use-package consult-flycheck
  :ensure t
  :after flycheck
  :general (flycheck-mode-map "M-g f" 'consult-flycheck))

(use-package corfu
  :ensure t
  :custom (corfu-cycle t)
  :hook (elpaca-after-init-hook . global-corfu-mode))

(use-package css-ts-mode
  :treesit)

(use-package datetime
  :ensure t
  :custom (datetime-timezone 'America/Chicago))

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
  (disproject-switch-to-buffer-command #'consult-project-buffer)
  :general (ctl-x-map "p" 'disproject-dispatch))

(use-package dumb-jump
  :ensure t
  :custom
  (dumb-jump-prefer-searcher 'rg)
  (dumb-jump-selector 'completing-read)
  :hook (xref-backend-functions . dumb-jump-xref-activate))

(use-package edit-indirect
  :ensure t)

(use-package editorconfig
  :hook elpaca-after-init-hook)

(use-package ef-themes
  :ensure (ef-themes :host github :repo "protesilaos/ef-themes" :tag "1.11.0")
  :custom
  (ef-themes-common-palette-overrides
   '((bg-mode-line bg-alt))))

(use-package eglot
  :custom
  (eglot-autoshutdown t)
  (eglot-confirm-server-edits nil)
  (eglot-ignored-server-capabilities '(:documentHighlightProvider :inlayHintProvider))
  (eglot-sync-connect nil)
  :general
  (eglot-mode-map
   :prefix "C-c l"
   "a" 'eglot-code-actions
   "f b" 'eglot-format-buffer
   "f f" 'eglot-format
   "r" 'eglot-rename))

(use-package eldoc-box
  :ensure t
  :custom (eldoc-box-clear-with-C-g t)
  :general ("C-c k" 'eldoc-box-help-at-point))

(use-package embark
  :ensure t
  :general ("C-." 'embark-act)
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
  :general ("C-=" 'er/expand-region))

(use-package faces
  :when (display-graphic-p)
  :config
  (dolist (face '(default tooltip))
    (set-face-attribute face nil :font "MonoLisa Variable 12")))

(use-package files
  :custom
  (confirm-kill-processes nil)
  (major-mode-remap-alist
   '((c++-mode . c++-ts-mode)
     (c-mode . c-ts-mode)
     (clojure-mode . clojure-ts-mode)
     (clojurec-mode . clojure-ts-clojurec-mode)
     (clojuredart-mode . clojure-ts-clojuredart-mode)
     (clojurescript-mode . clojure-ts-clojurescript-mode)
     (conf-toml-mode . toml-ts-mode)
     (css-mode . css-ts-mode)
     (jank-mode . clojure-ts-jank-mode)
     (java-mode . java-ts-mode)
     (javascript-mode . js-ts-mode)
     (joker-mode . clojure-ts-joker-mode)
     (js-json-mode . json-ts-mode)
     (mhtml-mode . html-ts-mode)
     (python-mode . python-ts-mode)
     (ruby-mode . ruby-ts-mode)
     (sh-mode . bash-ts-mode)))
  (require-final-newline t))

(use-package fish-mode
  :ensure t)

(use-package flycheck
  :ensure t
  :custom (flycheck-indication-mode nil)
  :hook (elpaca-after-init-hook . global-flycheck-mode))

(use-package flycheck-clj-kondo
  :ensure t
  :demand t
  :after clojure-ts-mode)

(use-package flycheck-eglot
  :ensure t
  :custom
  (flycheck-eglot-enable-diagnostic-tags nil)
  (flycheck-eglot-exclusive nil)
  :hook (elpaca-after-init-hook . global-flycheck-eglot-mode))

(use-package flyover
  :ensure t
  :custom
  (flyover-base-height 1)
  (flyover-display-mode 'show-only-on-same-line)
  (flyover-show-icon nil)
  (flyover-text-tint-percent 75)
  (flyover-virtual-line-type 'line-no-arrow)
  :hook flycheck-mode-hook)

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

(use-package hideshow
  :hook (prog-mode-hook . hs-minor-mode))

(use-package hl-todo
  :ensure t
  :hook (elpaca-after-init-hook . global-hl-todo-mode))

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

(use-package logview
  :ensure t)

(use-package magit
  :ensure t
  :custom
  (magit-bury-buffer-function 'magit-restore-window-configuration)
  (magit-clone-default-directory "~/Developer/")
  (magit-diff-refine-hunk t)
  (magit-display-buffer-function 'magit-display-buffer-fullframe-status-v1)
  (magit-format-file-function 'magit-format-file-nerd-icons)
  (magit-no-message '("Turning on magit-auto-revert-mode...")))

(use-package marginalia
  :ensure t
  :hook elpaca-after-init-hook)

(use-package markdown-mode
  :ensure t
  :custom (markdown-fontify-code-blocks-natively t))

(use-package misc
  :general ("M-z" 'zap-up-to-char))

(use-package mood-line
  :ensure (mood-line :host gitlab :repo "dpassen/mood-line")
  :hook elpaca-after-init-hook)

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
  :hook elpaca-after-init-hook)

(use-package orderless
  :ensure t
  :custom
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-styles '(orderless basic)))

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

(use-package savehist
  :hook elpaca-after-init-hook)

(use-package saveplace
  :hook (elpaca-after-init-hook . save-place-mode))

(use-package simple
  :custom
  (async-shell-command-buffer 'new-buffer)
  (column-number-mode t)
  (read-quoted-char-radix 16))

(use-package smartparens
  :ensure t
  :custom (sp-highlight-pair-overlay nil)
  :config
  (require 'smartparens-config)
  (sp-use-smartparens-bindings)
  :hook prog-mode-hook
  ((cider-repl-mode-hook
    clojure-ts-mode-hook
    eval-expression-minibuffer-setup-hook
    lisp-data-mode-hook) . smartparens-strict-mode))

(use-package spacious-padding
  :ensure t
  :when (display-graphic-p)
  :hook elpaca-after-init-hook)

(use-package stillness-mode
  :ensure t
  :hook elpaca-after-init-hook)

(use-package subword
  :hook (elpaca-after-init-hook . global-subword-mode))

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

(use-package uniquify
  :custom (uniquify-buffer-name-style 'forward))

(use-package verb
  :ensure t
  :after org
  :general (org-mode-map "C-c C-r" verb-command-map))

(use-package vertico
  :ensure (vertico :files (:defaults "extensions/*"))
  :custom
  (vertico-count-format nil)
  (vertico-cycle t)
  (vertico-multiform-commands
   '((execute-extended-command reverse)
     (execute-extended-command-for-buffer reverse)))
  (vertico-resize nil)
  :config (vertico-multiform-mode 1)
  :hook elpaca-after-init-hook)

(use-package vundo
  :ensure t
  :custom (vundo-glyph-alist vundo-unicode-symbols)
  :general ("C-c u" 'vundo))

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
  :hook (elpaca-after-init-hook . global-mise-mode))

(use-package exec-path-from-shell
  :ensure t
  :when (memq window-system '(mac ns x))
  :hook (elpaca-after-init-hook . exec-path-from-shell-initialize))

;; Local Variables:
;; no-byte-compile: t
;; no-native-compile: t
;; no-update-autoloads: t
;; End:

;;; init.el ends here
