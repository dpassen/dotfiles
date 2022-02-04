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
           (enable-recursive-minibuffers . t)
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
  (fset 'yes-or-no-p 'y-or-n-p))

(leaf apheleia
  :ensure t
  :hook prog-mode-hook)

(leaf autorevert
  :custom (auto-revert-verbose . nil)
  :global-minor-mode global-auto-revert-mode)

(leaf cider
  :ensure t
  :custom ((cider-font-lock-dynamically . nil)
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
                       (clojure-project-dir))))

(leaf clojure-mode
  :ensure t
  :custom (clojure-align-forms-automatically . t))

(leaf company
  :ensure t
  :hook (prog-mode-hook cider-repl-mode-hook))

(leaf customize
  :custom `(custom-file . ,(concat user-emacs-directory "custom.el"))
  :config (load custom-file 'noerror))

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
  :custom-face (eglot-highlight-symbol-face . '((t :inherit 'normal)))
  :hook (clojure-mode-hook . eglot-ensure))

(leaf expand-region
  :ensure t
  :bind ("C-=" . er/expand-region))

(leaf flymake
  :hook prog-mode-hook
  :bind (flymake-mode-map
         ("C-c ! c" . flymake-start)
         ("C-c ! l" . flymake-show-buffer-diagnostics)
         ("C-c ! n" . flymake-goto-next-error)
         ("C-c ! p" . flymake-goto-prev-error))
  :defun flymake-proc-legacy-flymake
  :config
  (remove-hook 'flymake-diagnostic-functions #'flymake-proc-legacy-flymake))

(leaf flymake-shellcheck
  :hook (sh-mode-hook . flymake-shellcheck-load))

(leaf hideshow
  :hook (prog-mode-hook . hs-minor-mode))

(leaf ibuffer
  :bind ("C-x C-b" . ibuffer))

(leaf initial-size
  :when (display-graphic-p)
  :config
  (add-to-list 'default-frame-alist '(height . 50))
  (add-to-list 'default-frame-alist '(width . 120)))

(leaf just-mode
  :ensure t)

(leaf magit
  :ensure t
  :bind (("C-x g" . magit-status)
         ("C-c g" . magit-file-dispatch)))

(leaf markdown-mode
  :ensure t)

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
           (orderless-component-separator . " +\\|[-/_\.]")))

(leaf paredit
  :ensure t
  :bind (paredit-mode-map
         ("M-?" . nil))
  :hook (cider-repl-mode-hook
         clojure-mode-hook
         emacs-lisp-mode-hook
         eval-expression-minibuffer-setup-hook))

(leaf poetry
  :ensure t)

(leaf pragmata-pro
  :config
  (let ((default-font "PragmataPro Liga 12"))
    (add-to-list 'default-frame-alist `(font . ,default-font))
    (set-face-attribute 'default t :font default-font)))

(leaf railwaycat
  :when (display-graphic-p)
  :custom ((mac-command-modifier . nil)
           (mac-option-modifier . 'meta))
  :global-minor-mode mac-auto-operator-composition-mode)

(leaf restclient
  :ensure t)

(leaf savehist
  :global-minor-mode t)

(leaf save-place
  :global-minor-mode t)

(leaf subword
  :hook prog-mode-hook)

(leaf uniquify
  :custom (uniquify-buffer-name-style . 'forward))

(leaf vertico
  :ensure t
  :custom ((vertico-count . 18)
           (vertico-count-format . nil)
           (vertico-cycle . t))
  :global-minor-mode t)

(leaf vertico-posframe
  :ensure t
  :custom (vertico-posframe-parameters . '((left-fringe . 8)
                                           (right-fringe . 8)))
  :after vertico
  :global-minor-mode t)

(leaf web-mode
  :ensure t
  :mode ("\\.html?\\'" "\\.jsx?\\'" "\\.tsx?\\'" "\\.css\\'")
  :custom ((web-mode-code-indent-offset . 2)
           (web-mode-css-indent-offset . 2)
           (web-mode-enable-auto-closing . t)
           (web-mode-markup-indent-offset . 2)))

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
  :global-minor-mode t)

(provide 'init)

;;; init.el ends here
