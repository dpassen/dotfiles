;;; init.el --- Initialization code ;;; -*- lexical-binding: t;-*-
;;; Commentary:

;;; Code:

(defvar elpaca-installer-version 0.6)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil
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
        (if-let ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                 ((zerop (call-process "git" nil buffer t "clone"
                                       (plist-get order :repo) repo)))
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
  (setopt use-package-hook-name-suffix nil))

(elpaca-wait)

(use-package general
  :elpaca t)

(elpaca-wait)

(use-package emacs
  :defer t
  :custom
  (indent-tabs-mode nil)
  (inhibit-startup-screen t)
  (initial-scratch-message ";; rebellious pro\n\n")
  (load-prefer-newer t)
  (ring-bell-function 'ignore)
  (use-short-answers t)
  :init
  (setq frame-title-format '("%b — emacs")
        kill-buffer-query-functions nil
        message-truncate-lines t
        read-process-output-max (* 1024 1024)))

(use-package apheleia
  :elpaca t
  :hook (elpaca-after-init-hook . apheleia-global-mode))

(use-package auto-dark
  :elpaca t
  :custom
  (auto-dark-dark-theme 'modus-vivendi)
  (auto-dark-light-theme 'modus-operandi)
  :hook elpaca-after-init-hook)

(use-package autorevert
  :custom (auto-revert-verbose nil)
  :hook (elpaca-after-init-hook .  global-auto-revert-mode))

(use-package cape
  :elpaca t
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
  :elpaca t
  :defer t
  :custom
  (cider-connection-message-fn nil)
  (cider-font-lock-dynamically nil)
  (cider-ns-save-files-on-refresh t)
  (cider-prompt-for-symbol nil)
  (cider-repl-display-help-banner nil)
  (cider-repl-pop-to-buffer-on-connect nil)
  (cider-save-file-on-load t)
  (cider-use-fringe-indicators nil))

(use-package clojure-mode
  :elpaca t
  :defer t
  :custom (clojure-align-forms-automatically t))

(use-package comp
  :defer t
  :custom
  (native-comp-async-report-warnings-errors nil)
  (native-comp-jit-compilation-deny-list '(".*-loaddefs.el.gz")))

(use-package consult
  :elpaca t
  :custom
  (consult-after-jump-hook '(recenter))
  (consult-goto-line-numbers nil)
  (xref-show-definitions-function #'consult-xref)
  (xref-show-xrefs-function #'consult-xref)
  :general
  ("C-x b" 'consult-buffer
   "C-x p b" 'consult-project-buffer
   "M-g M-g" 'consult-goto-line
   "M-g g" 'consult-goto-line
   "M-s l" 'consult-line
   "M-s r" 'consult-ripgrep))

(use-package consult-flycheck
  :elpaca t
  :defer t
  :after flycheck
  :general ("M-g f" 'consult-flycheck))

(use-package corfu
  :elpaca t
  :custom (corfu-cycle t)
  :hook (elpaca-after-init-hook . global-corfu-mode))

(use-package cus-edit
  :defer t
  :custom (custom-file (expand-file-name "custom.el" user-emacs-directory))
  :init (load custom-file 'noerror))

(use-package datetime
  :elpaca t
  :defer t
  :custom (datetime-timezone 'America/Chicago))

(use-package dired
  :defer t
  :custom (dired-kill-when-opening-new-dired-buffer t))

(use-package dumb-jump
  :elpaca t
  :custom (dumb-jump-force-searcher 'rg)
  :hook (xref-backend-functions . dumb-jump-xref-activate))

(use-package eat
  :elpaca t
  :custom
  (eat-enable-shell-prompt-annotation nil)
  (eat-kill-buffer-on-exit t)
  :general ("C-x RET" 'eat-project-other-window))

(use-package edit-indirect
  :elpaca t
  :defer t)

(use-package editorconfig
  :elpaca t
  :hook elpaca-after-init-hook)

(use-package eglot
  :custom
  (eglot-autoshutdown t)
  (eglot-confirm-server-initiated-edits nil)
  (eglot-extend-to-xref t)
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
  :elpaca t
  :general
  ("C-." 'embark-act
   "C-;" 'embark-dwim)
  :init (setq prefix-help-command 'embark-prefix-help-command))

(use-package embark-consult
  :elpaca t
  :hook (embark-collect-mode-hook . consult-preview-at-point-mode))

(use-package envrc
  :elpaca t
  :general
  (envrc-mode-map
   "C-c e" 'envrc-command-map)
  :hook (elpaca-after-init-hook . envrc-global-mode))

(use-package eros
  :elpaca t
  :hook lisp-data-mode-hook)

(use-package exec-path-from-shell
  :elpaca t
  :when (memq window-system '(mac ns x))
  :hook (elpaca-after-init-hook . exec-path-from-shell-initialize))

(use-package expand-region
  :elpaca t
  :custom (expand-region-show-usage-message nil)
  :general ("C-=" 'er/expand-region))

(use-package faces
  :when (display-graphic-p)
  :defer t
  :config
  (dolist (face '(default tooltip))
    (set-face-attribute face nil :font "PragmataPro Liga 12")))

(use-package files
  :defer t
  :custom
  (confirm-kill-processes nil)
  (require-final-newline t))

(use-package flycheck
  :elpaca t
  :custom (flycheck-indication-mode nil)
  :hook (elpaca-after-init-hook . global-flycheck-mode))

(use-package flycheck-clj-kondo
  :elpaca t
  :after clojure-mode)

(use-package flycheck-eglot
  :elpaca t
  :after (eglot flycheck)
  :custom (flycheck-eglot-exclusive nil)
  :config (global-flycheck-eglot-mode 1))

(use-package frame
  :when (display-graphic-p)
  :defer t
  :config
  (dolist (frame-parameters '((height . 50)
                              (width . 120)
                              (ns-transparent-titlebar . t)))
    (add-to-list 'default-frame-alist frame-parameters)))

(use-package gcmh
  :elpaca t
  :hook elpaca-after-init-hook)

(use-package git-link
  :elpaca t
  :defer t
  :custom (git-link-use-commit t))

(use-package git-modes
  :elpaca t
  :defer t)

(use-package git-timemachine
  :elpaca t
  :defer t)

(use-package golden-ratio
  :elpaca t
  :hook elpaca-after-init-hook)

(use-package hideshow
  :hook (prog-mode-hook . hs-minor-mode))

(use-package html-ts-mode
  :elpaca (html-ts-mode :type git :host github :repo "mickeynp/html-ts-mode")
  :defer t)

(use-package ibuffer
  :general ("C-x C-b" 'ibuffer))

(use-package jarchive
  :elpaca t
  :defer t
  :after eglot
  :init (jarchive-setup))

(use-package kotlin-ts-mode
  :elpaca t
  :defer t)

(use-package ligature
  :elpaca t
  :init
  (ligature-set-ligatures
   'prog-mode
   '("[ERROR]" "[DEBUG]" "[INFO]" "[WARN]" "[WARNING]" "[ERR]" "[FATAL]"
     "[TRACE]" "[FIXME]" "[TODO]" "[BUG]" "[NOTE]" "[HACK]" "[MARK]"
     "!!" "!=" "!==" "!!!" "!≡" "!≡≡" "!>" "!=<" "#(" "#_" "#{" "#?" "#>" "##"
     "#_(" "%=" "%>" "%>%" "%<%" "&%" "&&" "&*" "&+" "&-" "&/" "&=" "&&&" "&>"
     "$>" "***" "*=" "*/" "*>" "++" "+++" "+=" "+>" "++=" "--" "-<" "-<<" "-="
     "->" "->>" "---" "-->" "-+-" "-\\/" "-|>" "-<|" ".." "..." "..<" ".>" ".~"
     ".=" "/*" "//" "/>" "/=" "/==" "///" "/**" ":::" "::" ":=" ":≡" ":>" ":=>"
     ":(" ":-(" ":)" ":-)" ":/" ":\\" ":3" ":D" ":P" ":>:" ":<:" "<$>" "<*"
     "<*>" "<+>" "<-" "<<" "<<<" "<<=" "<=" "<=>" "<>" "<|>" "<<-" "<|" "<=<"
     "<~" "<~~" "<<~" "<$" "<+" "<!>" "<@>" "<#>" "<%>" "<^>" "<&>" "<?>" "<.>"
     "</>" "<\\>" "<\">" "<:>" "<~>" "<**>" "<<^" "<!" "<@" "<#" "<%" "<^" "<&"
     "<?" "<." "</" "<\\" "<\"" "<:" "<->" "<!--" "<--" "<~<" "<==>" "<|-" "<<|"
     "<-<" "<-->" "<<==" "<==" "=<<" "==" "===" "==>" "=>" "=~" "=>>" "=/="
     "=~=" "==>>" "≡≡" "≡≡≡" "≡:≡" ">-" ">=" ">>" ">>-" ">>=" ">>>" ">=>" ">>^"
     ">>|" ">!=" ">->" "??" "?~" "?=" "?>" "???" "?." "^=" "^." "^?" "^.." "^<<"
     "^>>" "^>" "\\\\" "\\>" "\\/-" "@>" "|=" "||" "|>" "|||" "|+|" "|->" "|-->"
     "|=>" "|==>" "|>-" "|<<" "||>" "|>>" "|-" "||-" "~=" "~>" "~~>" "~>>" "[["
     "]]" "\">" "_|_"))
  :hook (elpaca-after-init-hook . global-ligature-mode))

(use-package logview
  :elpaca t
  :defer t)

(use-package lua-mode
  :elpaca t
  :defer t)

(use-package magit
  :elpaca t
  :defer t
  :custom
  (magit-bury-buffer-function 'magit-restore-window-configuration)
  (magit-diff-refine-hunk t)
  (magit-display-buffer-function 'magit-display-buffer-fullframe-status-v1))

(use-package marginalia
  :elpaca t
  :hook elpaca-after-init-hook)

(use-package markdown-mode
  :elpaca t
  :defer t)

(use-package misc
  :general ("M-z" 'zap-up-to-char))

(use-package modus-themes
  :defer t
  :custom
  (modus-themes-fringes nil)
  (modus-themes-italic-constructs t)
  (modus-themes-mode-line '(accented borderless))
  (modus-themes-region '(accented bg-only)))

(use-package mood-line
  :elpaca t
  :custom
  (mood-line-format
   (mood-line-defformat
    :left
    (((mood-line-segment-buffer-status)    . " ")
     ((mood-line-segment-buffer-name)      . "  ")
     ((mood-line-segment-cursor-position)  . " ")
     ((mood-line-segment-scroll)           . " ")
     (mood-line-segment-region))
    :right
    (((mood-line-segment-eol)         . "  ")
     ((mood-line-segment-encoding)    . "  ")
     ((mood-line-segment-vc)          . "  ")
     ((mood-line-segment-major-mode)  . "  ")
     ((mood-line-segment-misc-info)   . "  ")
     ((mood-line-segment-checker)     . "  ")
     ((mood-line-segment-process)     . "  "))))
  (mood-line-glyph-alist mood-line-glyphs-fira-code)
  :hook elpaca-after-init-hook)

(use-package orderless
  :elpaca t
  :defer t
  :custom
  (completion-category-overrides '((file (styles basic partial-completion))))
  (completion-styles '(orderless basic)))

(use-package paren
  :defer t
  :custom (show-paren-mode nil))

(use-package project
  :defer t
  :custom (project-switch-commands 'project-find-file)
  :config
  (dolist (mode '(cider-repl-mode eat-mode shell-mode))
    (add-to-list 'project-kill-buffer-conditions `(major-mode . ,mode) t)))

(use-package savehist
  :hook elpaca-after-init-hook)

(use-package saveplace
  :hook (elpaca-after-init-hook . save-place-mode))

(use-package simple
  :defer t
  :custom
  (async-shell-command-buffer 'new-buffer)
  (column-number-mode t)
  (read-quoted-char-radix 16))

(use-package smartparens
  :elpaca t
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
  :elpaca t
  :hook elpaca-after-init-hook)

(use-package subword
  :hook (elpaca-after-init-hook . global-subword-mode))

(use-package treesit-auto
  :elpaca t
  :custom
  (treesit-auto-langs
   '(bash c cpp css html java javascript json kotlin python ruby rust toml tsx typescript))
  :hook (elpaca-after-init-hook . treesit-auto-add-to-auto-mode-alist))

(use-package uniquify
  :defer t
  :custom (uniquify-buffer-name-style 'forward))

(use-package verb
  :elpaca t
  :defer t
  :after org
  :general
  (org-mode-map
   "C-c C-r" verb-command-map))

(use-package vertico
  :elpaca (vertico :files (:defaults "extensions/*"))
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
  :elpaca t
  :custom (vundo-glyph-alist vundo-unicode-symbols)
  :general ("C-c u" 'vundo))

(use-package wgrep
  :elpaca t
  :defer t
  :custom (wgrep-auto-save-buffer t))

(use-package xref
  :defer t
  :custom
  (xref-after-jump-hook '(recenter))
  (xref-after-return-hook nil)
  (xref-history-storage 'xref-window-local-history)
  (xref-search-program 'ripgrep))

(use-package yaml-mode
  :elpaca t
  :defer t)

;; Local Variables:
;; no-byte-compile: t
;; no-native-compile: t
;; no-update-autoloads: t
;; End:

;;; init.el ends here
