;;; init.el --- Initialization code ;;; -*- lexical-binding: t;-*-
;;; Commentary:

;;; Code:

(defvar elpaca-installer-version 0.3)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil
                              :files (:defaults (:exclude "extensions"))
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
            (kill-buffer buffer)
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (load "./elpaca-autoloads")))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

(elpaca elpaca-use-package
  (elpaca-use-package-mode))

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
  (setq frame-title-format '("%b — emacs"))
  (setq kill-buffer-query-functions nil)
  (setq message-truncate-lines t))

(use-package emacs-mac
  :when (eq system-type 'darwin)
  :defer t
  :custom
  (mac-command-modifier nil)
  (mac-frame-tabbing t)
  (mac-option-modifier 'meta)
  :init
  (global-unset-key [swipe-left])
  (global-unset-key [swipe-right]))

(use-package apheleia
  :elpaca t
  :defer t
  :init (apheleia-global-mode 1))

(use-package autorevert
  :defer t
  :custom (auto-revert-verbose nil)
  :init (global-auto-revert-mode 1))

(use-package beframe
  :elpaca t
  :defer t
  :custom
  (beframe-create-frame-scratch-buffer nil)
  (beframe-functions-in-frames '(project-prompt-project-dir))
  :init (beframe-mode 1))

(use-package cape
  :elpaca t
  :bind
  (("C-c p p" . completion-at-point)
   ("C-c p d" . cape-dabbrev)
   ("C-c p f" . cape-file)
   ("C-c p i" . cape-ispell)
   ("C-c p k" . cape-keyword)
   ("C-c p s" . cape-symbol)))

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
  (cider-use-fringe-indicators nil)
  :config
  (setq cider-repl-history-file
        (expand-file-name
         ".cider-repl-history"
         (clojure-project-dir))))

(use-package clojure-mode
  :elpaca t
  :defer t
  :custom (clojure-align-forms-automatically t))

(use-package corfu
  :elpaca t
  :defer t
  :custom (corfu-cycle t)
  :init (global-corfu-mode 1))

(use-package cus-edit
  :defer t
  :custom (custom-file (expand-file-name "custom.el" user-emacs-directory))
  :init (load custom-file 'noerror))

(use-package default-text-scale
  :elpaca t
  :defer t
  :init (default-text-scale-mode 1))

(use-package dired
  :defer t
  :custom (dired-kill-when-opening-new-dired-buffer t))

(use-package dumb-jump
  :elpaca t
  :defer t
  :custom (dumb-jump-force-searcher 'rg)
  :init (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))

(use-package edit-indirect
  :elpaca t
  :defer t)

(use-package editorconfig
  :elpaca t
  :defer t
  :init (editorconfig-mode 1))

(use-package envrc
  :elpaca t
  :bind (:map envrc-mode-map
              ("C-c e" . envrc-command-map))
  :init (envrc-global-mode 1))

(use-package exec-path-from-shell
  :elpaca t
  :when (memq window-system '(mac ns x))
  :defer t
  :init (exec-path-from-shell-initialize))

(use-package expand-region
  :elpaca t
  :custom (expand-region-show-usage-message nil)
  :bind ("C-=" . er/expand-region))

(use-package files
  :defer t
  :custom
  (confirm-kill-processes nil)
  (require-final-newline t))

(use-package flycheck
  :elpaca t
  :defer t
  :custom (flycheck-indication-mode nil)
  :init (global-flycheck-mode 1))

(use-package flycheck-clj-kondo
  :elpaca t
  :demand t
  :after clojure-mode)

(use-package flycheck-color-mode-line
  :elpaca t
  :custom (flycheck-color-mode-line-show-running nil)
  :after flycheck
  :hook flycheck-mode)

(use-package frame
  :when (display-graphic-p)
  :defer t
  :config
  (add-to-list 'default-frame-alist '(height . 50))
  (add-to-list 'default-frame-alist '(width . 120))
  (set-frame-font "PragmataPro Liga 12" nil t))

(use-package git-link
  :elpaca t
  :defer t
  :custom (git-link-use-commit t))

(use-package git-timemachine
  :elpaca t
  :defer t)

(use-package hideshow
  :hook (prog-mode . hs-minor-mode))

(use-package ibuffer
  :bind ("C-x C-b" . ibuffer))

(use-package ligature
  :elpaca t
  :defer t
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
  (global-ligature-mode 1))

(use-package lua-mode
  :elpaca t
  :defer t)

(use-package magit
  :elpaca t
  :defer t
  :custom (magit-diff-refine-hunk t))

(use-package marginalia
  :elpaca t
  :defer t
  :init (marginalia-mode 1))

(use-package markdown-mode
  :elpaca t
  :defer t)

(use-package minions
  :elpaca t
  :defer t
  :custom
  (minions-available-modes nil)
  (minions-mode-line-lighter "⋯")
  :init (minions-mode 1))

(use-package misc
  :bind ("M-z" . zap-up-to-char))

(use-package modus-themes
  :custom
  (modus-themes-italic-constructs t)
  (modus-themes-mode-line '(borderless))
  (modus-themes-region '(accented bg-only))
  (modus-themes-subtle-line-numbers t)
  :init
  (let ((initial-theme (pcase (plist-get (mac-application-state) :appearance)
                         ("NSAppearanceNameAqua" 'modus-operandi)
                         ("NSAppearanceNameDarkAqua" 'modus-vivendi)
                         (_default 'modus-operandi))))
    (load-theme initial-theme))
  :hook (mac-effective-appearance-change . modus-themes-toggle))

(use-package orderless
  :elpaca t
  :defer t
  :custom
  (completion-category-overrides '((cider (styles basic))
                                   (file (styles basic partial-completion))))
  (completion-styles '(orderless basic)))

(use-package paren
  :defer t
  :custom (show-paren-mode nil))

(use-package project
  :defer t
  :custom (project-switch-commands 'project-find-file))

(use-package restclient
  :elpaca t
  :defer t)

(use-package savehist
  :defer t
  :init (savehist-mode 1))

(use-package saveplace
  :defer t
  :init (save-place-mode 1))

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
  :hook (prog-mode . smartparens-strict-mode))

(use-package subword
  :defer t
  :init (global-subword-mode 1))

(use-package uniquify
  :defer t
  :custom (uniquify-buffer-name-style 'forward))

(use-package vertico
  :elpaca (vertico :files (:defaults "extensions/*"))
  :defer t
  :custom
  (vertico-count-format nil)
  (vertico-cycle t)
  (vertico-resize nil)
  :init (vertico-mode 1))

(use-package vertico-reverse-mode
  :after vertico
  :defer t
  :init (vertico-reverse-mode 1))

(use-package vterm
  :elpaca t
  :defer t
  :custom
  (vterm-always-compile-module t)
  (vterm-clear-scrollback-when-clearing t))

(use-package vterm-toggle
  :elpaca t
  :custom (vterm-toggle-scope 'project)
  :bind ("C-x RET" . vterm-toggle))

(use-package web-mode
  :elpaca t
  :mode ("\\.html?\\'" "\\.jsx?\\'" "\\.tsx?\\'" "\\.css\\'" "\\.json\\'")
  :custom
  (web-mode-code-indent-offset 2)
  (web-mode-css-indent-offset 2)
  (web-mode-enable-auto-closing t)
  (web-mode-markup-indent-offset 2))

(use-package with-editor
  :elpaca t
  :hook (vterm-mode . with-editor-export-editor))

(use-package xref
  :defer
  :custom
  (xref-after-jump-hook '(recenter))
  (xref-after-return-hook nil)
  (xref-search-program 'ripgrep)
  (xref-show-definitions-function #'xref-show-definitions-completing-read))

(use-package yaml-mode
  :elpaca t
  :defer t)

(use-package zoom
  :elpaca t
  :defer t
  :custom (zoom-size '(0.618 . 0.618))
  :init (zoom-mode 1))

(provide 'init)

;; Local Variables:
;; no-byte-compile: t
;; no-native-compile: t
;; no-update-autoloads: t
;; End:

;;; init.el ends here
