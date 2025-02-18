;;; init.el --- Initialization code ;;; -*- lexical-binding: t;-*-
;;; Commentary:

;;; Code:

(setopt custom-file (locate-user-emacs-file "custom.el"))
(load custom-file :no-error-if-file-is-missing)

(defvar elpaca-installer-version 0.9)
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
    (load "./elpaca-autoloads")))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

(elpaca elpaca-use-package
  (elpaca-use-package-mode)
  (setopt use-package-always-defer t
          use-package-hook-name-suffix nil))

(use-package general
  :ensure (:wait t)
  :demand t)

(use-package emacs
  :custom
  (frame-resize-pixelwise t)
  (indent-tabs-mode nil)
  (inhibit-startup-screen t)
  (initial-scratch-message ";; rebellious pro\n\n")
  (load-prefer-newer t)
  (ring-bell-function 'ignore)
  (use-short-answers t)
  :init
  (setq frame-title-format "%b\n"
        kill-buffer-query-functions nil
        message-truncate-lines t
        read-process-output-max (* 1024 1024)))

(use-package apheleia
  :ensure t
  :hook (elpaca-after-init-hook . apheleia-global-mode))

(use-package auto-dark
  :ensure t
  :custom
  (auto-dark-dark-theme 'modus-vivendi)
  (auto-dark-light-theme 'modus-operandi)
  :hook elpaca-after-init-hook)

(use-package autorevert
  :custom (auto-revert-verbose nil)
  :hook (elpaca-after-init-hook .  global-auto-revert-mode))

(use-package cape
  :ensure t
  :after corfu
  :general
  (corfu-mode-map
   :prefix "C-c p"
   "p" 'completion-at-point
   "d" 'cape-dabbrev
   "f" 'cape-file
   "i" 'cape-ispell
   "k" 'cape-keyword
   "s" 'cape-elisp-symbol))

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
  :ensure t
  :custom
  (clojure-align-forms-automatically t)
  (clojure-toplevel-inside-comment-form t))

(use-package comp
  :custom
  (native-comp-async-report-warnings-errors nil)
  (native-comp-jit-compilation-deny-list '(".*-loaddefs.el.gz")))

(use-package consult
  :ensure t
  :custom
  (consult-after-jump-hook '(recenter))
  (consult-goto-line-numbers nil)
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
           "r" 'consult-ripgrep))

(use-package consult-flycheck
  :ensure t
  :after flycheck
  :general (flycheck-mode-map "M-g f" 'consult-flycheck))

(use-package corfu
  :ensure t
  :custom (corfu-cycle t)
  :hook (elpaca-after-init-hook . global-corfu-mode))

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

(use-package disproject
  :ensure t
  :custom
  (disproject-find-line-command #'consult-line-multi)
  (disproject-shell-command #'vterm)
  (disproject-switch-to-buffer-command #'consult-project-buffer)
  :general (ctl-x-map "p" 'disproject-dispatch))

(use-package doom-modeline
  :ensure t
  :custom
  (doom-modeline-bar-width 0.1)
  (doom-modeline-buffer-file-name-style 'relative-to-project)
  (doom-modeline-buffer-state-icon nil)
  (doom-modeline-check-simple-format t)
  (doom-modeline-display-misc-in-all-mode-lines nil)
  (doom-modeline-env-version nil)
  (doom-modeline-major-mode-icon nil)
  (doom-modeline-minor-modes t)
  (doom-modeline-project-name t)
  :hook elpaca-after-init-hook)

(use-package dumber-jump
  :ensure t
  :hook (xref-backend-functions . dumber-jump-xref-activate))

(use-package edit-indirect
  :ensure t)

(use-package editorconfig
  :ensure t
  :hook elpaca-after-init-hook)

(use-package eglot
  :custom
  (eglot-autoshutdown t)
  (eglot-confirm-server-initiated-edits nil)
  (eglot-ignored-server-capabilities '(:inlayHintProvider))
  (eglot-sync-connect nil)
  :custom-face (eglot-highlight-symbol-face ((t :inherit normal)))
  :general
  (eglot-mode-map
   :prefix "C-c l"
   "a" 'eglot-code-actions
   "f b" 'eglot-format-buffer
   "f f" 'eglot-format
   "r" 'eglot-rename))

(use-package embark
  :ensure t
  :general
  ("C-." 'embark-act
   "C-;" 'embark-dwim)
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
    (set-face-attribute face nil :font "PragmataPro 12")))

(use-package files
  :custom
  (confirm-kill-processes nil)
  (require-final-newline t))

(use-package flycheck
  :ensure t
  :custom (flycheck-indication-mode nil)
  :hook (elpaca-after-init-hook . global-flycheck-mode))

(use-package flycheck-clj-kondo
  :ensure t
  :demand t
  :after clojure-mode)

(use-package flycheck-eglot
  :ensure t
  :custom
  (flycheck-eglot-enable-diagnostic-tags nil)
  (flycheck-eglot-exclusive nil)
  :hook (elpaca-after-init-hook . global-flycheck-eglot-mode))

(use-package frame
  :when (display-graphic-p)
  :config
  (dolist (frame-parameters '((height . 50) (width . 120)))
    (push frame-parameters default-frame-alist)))

(use-package git-link
  :ensure t
  :custom (git-link-use-commit t))

(use-package git-modes
  :ensure t)

(use-package git-timemachine
  :ensure t)

(use-package golden
  :ensure (golden :host sourcehut :repo "wklew/golden")
  :hook (elpaca-after-init-hook . global-golden-mode))

(use-package hideshow
  :hook (prog-mode-hook . hs-minor-mode))

(use-package hl-todo
  :ensure t
  :hook (elpaca-after-init-hook . global-hl-todo-mode))

(use-package html-ts-mode
  :ensure (html-ts-mode :host github :repo "mickeynp/html-ts-mode"))

(use-package kotlin-ts-mode
  :ensure t)

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

(use-package minions
  :ensure t
  :hook elpaca-after-init-hook)

(use-package misc
  :general ("M-z" 'zap-up-to-char))

(use-package modus-themes
  :custom
  (modus-themes-fringes nil)
  (modus-themes-italic-constructs t)
  (modus-themes-mode-line '(accented borderless))
  (modus-themes-region '(accented bg-only)))

(use-package nerd-icons
  :ensure t
  :defer t)

(use-package nerd-icons-completion
  :ensure t
  :hook (marginalia-mode-hook . nerd-icons-completion-marginalia-setup))

(use-package nerd-icons-corfu
  :ensure t
  :hook (corfu-margin-formatters . nerd-icons-corfu-formatter))

(use-package nerd-icons-dired
  :ensure t
  :hook dired-mode-hook)

(use-package orderless
  :ensure t
  :custom
  (completion-category-overrides '((file (styles basic partial-completion))))
  (completion-styles '(orderless basic)))

(use-package paren
  :custom (show-paren-mode nil))

(use-package pixel-scroll
  :hook (elpaca-after-init-hook . pixel-scroll-precision-mode))

(use-package project
  :config
  (dolist (mode '(cider-repl-mode vterm-mode))
    (push `(major-mode . ,mode) project-kill-buffer-conditions)))

(use-package pulse
  :custom (pulse-flag 'never))

(use-package savehist
  :hook elpaca-after-init-hook)

(use-package saveplace
  :hook (elpaca-after-init-hook . save-place-mode))

(defun +elpaca-unload-seq (e)
  "Unload existing feature 'seq and activate package E."
  (and (featurep 'seq) (unload-feature 'seq t))
  (elpaca--continue-build e))

(defun +elpaca-seq-build-steps ()
  "Force seq package to be managed by elpaca and unloaded."
  (append
   (butlast (if (file-exists-p (expand-file-name "seq" elpaca-builds-directory))
                elpaca--pre-built-steps elpaca-build-steps))
   (list '+elpaca-unload-seq 'elpaca--activate-package)))

(use-package seq
  :ensure `(seq :build ,(+elpaca-seq-build-steps)))

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
    clojure-mode-hook
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

(use-package transient
  :ensure t)

(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-langs
   '(bash c cpp css html java javascript json kotlin python ruby rust toml tsx typescript))
  :hook (elpaca-after-init-hook . treesit-auto-add-to-auto-mode-alist))

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

(use-package vterm
  :ensure t
  :custom
  (vterm-always-compile-module t)
  (vterm-clear-scrollback-when-clearing t)
  (vterm-environment '("COLORTERM=truecolor")))

(use-package vundo
  :ensure t
  :custom (vundo-glyph-alist vundo-unicode-symbols)
  :general ("C-c u" 'vundo))

(use-package wgrep
  :ensure t
  :custom (wgrep-auto-save-buffer t))

(use-package winner
  :hook elpaca-after-init-hook)

(use-package with-editor
  :ensure t
  :hook (vterm-mode-hook . with-editor-export-editor))

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
