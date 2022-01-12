;;; init.el --- Initialization code ;;; -*- lexical-binding: t;-*-
;;; Commentary:

;;; Code:

(eval-and-compile
  (customize-set-variable
   'package-archives '(("melpa" . "https://melpa.org/packages/")
                       ("gnu" . "https://elpa.gnu.org/packages/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :config (leaf-keywords-init)))

(leaf emacs
  :custom ((column-number-mode . t)
           (confirm-kill-processes . nil)
           (indent-tabs-mode . nil)
           (inhibit-startup-screen . t)
           (load-prefer-newer . t)
           (read-quoted-char-radix . 16)
           (require-final-newline . t)
           (ring-bell-function . 'ignore))
  :setq `((frame-title-format . '("%b - emacs"))
          (kill-buffer-query-functions . nil)
          (message-truncate-lines . t)
          (read-process-output-max . ,(* 1024 1024)))
  :bind ("M-z" . zap-up-to-char)
  :config
  (fset 'yes-or-no-p 'y-or-n-p)

  (leaf autorevert
    :custom (auto-revert-verbose . nil)
    :global-minor-mode global-auto-revert-mode)

  (leaf customize
    :custom `(custom-file . ,(concat user-emacs-directory "custom.el"))
    :config (load custom-file 'noerror))

  (leaf ibuffer
    :bind ("C-x C-b" . ibuffer))

  (leaf initial-size
    :when (display-graphic-p)
    :config
    (add-to-list 'default-frame-alist '(height . 50))
    (add-to-list 'default-frame-alist '(width . 120)))

  (leaf minions
    :ensure t
    :custom ((minions-available-modes . '())
             (minions-mode-line-lighter . "⋯"))
    :defvar minions-direct
    :config (push 'flymake-mode minions-direct)
    :global-minor-mode t)

  (leaf modus-themes
    :ensure t
    :init (modus-themes-load-themes)
    :config
    (pcase (plist-get (mac-application-state) :appearance)
      ("NSAppearanceNameAqua" (modus-themes-load-operandi))
      ("NSAppearanceNameDarkAqua" (modus-themes-load-vivendi)))
    :hook (mac-effective-appearance-change-hook . modus-themes-toggle))

  (leaf orderless
    :ensure t
    :custom ((completion-styles . '(orderless))
             (orderless-component-separator . " +\\|[-/\.]")))

  (leaf pragmata-pro
    :config
    (let ((default-font "PragmataPro Liga 12"))
      (add-to-list 'default-frame-alist `(font . ,default-font))
      (set-face-attribute 'default t :font default-font)))

  (leaf railwaycat
    :when (display-graphic-p)
    :custom ((mac-command-modifier . nil)
             (mac-option-modifier . 'meta))
    :global-minor-mode (menu-bar-mode mac-auto-operator-composition-mode))

  (leaf savehist
    :global-minor-mode t)

  (leaf save-place
    :global-minor-mode t)

  (leaf uniquify
    :custom (uniquify-buffer-name-style . 'forward))

  (leaf vertico
    :ensure t
    :custom ((vertico-count-format . nil)
             (vertico-cycle . t)
             (vertico-resize . nil))
    :global-minor-mode t)

  (leaf vertico-reverse
    :after vertico
    :global-minor-mode t)

  (leaf with-editor
    :ensure t
    :hook (vterm-mode-hook . with-editor-export-editor)
    :init
    (leaf vterm
      :ensure t
      :bind ("C-x RET" . vterm-other-window)
      :custom ((vterm-always-compile-module . t)
               (vterm-clear-scrollback-when-clearing . t))))

  (leaf xref
    :custom (xref-search-program . 'ripgrep))

  (leaf zoom
    :ensure t
    :custom (zoom-size . '(0.618 . 0.618))
    :global-minor-mode t))

(leaf general-programming
  :config
  (leaf apheleia
    :ensure t
    :hook prog-mode-hook)

  (leaf company
    :ensure t
    :hook (prog-mode-hook cider-repl-mode-hook))

  (leaf dumb-jump
    :ensure t
    :custom (dumb-jump-prefer-searcher . 'rg)
    :config (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))

  (leaf editorconfig
    :ensure t
    :hook prog-mode-hook)

  (leaf eglot
    :ensure t
    :custom (eglot-confirm-server-initiated-edits . nil)
    :defvar eglot-server-programs
    :custom-face (eglot-highlight-symbol-face . '((t :inherit 'normal)))
    :hook (clojure-mode-hook . eglot-ensure)
    :config
    (add-to-list 'eglot-server-programs '(clojure-mode . ("clojure-lsp"))))

  (leaf expand-region
    :ensure t
    :bind ("C-c w" . er/expand-region))

  (leaf flymake
    :hook prog-mode-hook
    :bind (flymake-mode-map
           ("C-c ! c" . flymake-start)
           ("C-c ! l" . flymake-show-buffer-diagnostics)
           ("C-c ! n" . flymake-goto-next-error)
           ("C-c ! p" . flymake-goto-prev-error))
    :defun flymake-proc-legacy-flymake
    :config (remove-hook 'flymake-diagnostic-functions #'flymake-proc-legacy-flymake))

  (leaf hideshow
    :hook (prog-mode-hook . hs-minor-mode))

  (leaf just-mode
    :ensure t)

  (leaf magit
    :ensure t
    :bind (("C-x g" . magit-status)
           ("C-c g" . magit-file-dispatch)))

  (leaf markdown-mode
    :ensure t)

  (leaf paredit
    :ensure t
    :bind (paredit-mode-map
           ("M-?" . nil))
    :hook (cider-repl-mode-hook clojure-mode-hook emacs-lisp-mode-hook))

  (leaf subword
    :hook prog-mode-hook))

(leaf clojure
  :config
  (leaf clojure-mode
    :ensure t
    :custom (clojure-align-forms-automatically . t))

  (leaf cider
    :ensure t
    :custom ((cider-font-lock-dynamically . nil)
             (cider-mode-line-show-connection . nil)
             (cider-ns-save-files-on-refresh . t)
             (cider-prompt-for-symbol . nil)
             (cider-repl-display-help-banner . nil)
             (cider-repl-pop-to-buffer-on-connect . nil)
             (cider-save-file-on-load . t)
             (cider-use-fringe-indicators . nil))
    :defvar cider-repl-history-file
    :defun (clojure-project-dir . clojure-mode)
    :defer-config (setq cider-repl-history-file
                        (expand-file-name
                         ".cider-repl-history"
                         (clojure-project-dir)))))

(leaf python
  :config
  (leaf poetry
    :ensure t))

(leaf web-development
  :config
  (leaf emmet-mode
    :ensure t
    :custom (emmet-preview-default . nil)
    :bind (emmet-mode-keymap
           ("C-c w" . nil))
    :hook (web-mode-hook . emmet-mode))

  (leaf restclient
    :ensure t)

  (leaf web-mode
    :ensure t
    :mode ("\\.html?\\'" "\\.jsx?\\'" "\\.tsx?\\'" "\\.css\\'")
    :custom ((web-mode-code-indent-offset . 2)
             (web-mode-css-indent-offset . 2)
             (web-mode-enable-auto-closing . t)
             (web-mode-markup-indent-offset . 2))))

(provide 'init)

;;; init.el ends here
