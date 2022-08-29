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
  :custom ((async-shell-command-buffer . 'new-buffer)
           (column-number-mode . t)
           (confirm-kill-processes . nil)
           (indent-tabs-mode . nil)
           (inhibit-startup-screen . t)
           (load-prefer-newer . t)
           (read-quoted-char-radix . 16)
           (require-final-newline . t)
           (ring-bell-function . 'ignore)
           (use-short-answers . t))
  :setq ((frame-title-format . '("%b - emacs"))
         (kill-buffer-query-functions . nil)
         (message-truncate-lines . t))
  :bind ("M-z" . zap-up-to-char))

(leaf apheleia
  :ensure t
  :global-minor-mode apheleia-global-mode)

(leaf autorevert
  :custom (auto-revert-verbose . nil)
  :global-minor-mode global-auto-revert-mode)

(leaf cider
  :ensure t
  :custom ((cider-connection-message-fn . nil)
           (cider-font-lock-dynamically . nil)
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

(leaf corfu
  :ensure t
  :custom ((corfu-auto . t)
           (corfu-cycle . t))
  :global-minor-mode global-corfu-mode)

(leaf customize
  :custom `(custom-file . ,(concat user-emacs-directory "custom.el"))
  :config (load custom-file 'noerror))

(leaf default-text-scale
  :ensure t
  :global-minor-mode t)

(leaf dired
  :custom (dired-kill-when-opening-new-dired-buffer . t))

(leaf display-line-numbers
  :hook prog-mode-hook)

(leaf dumb-jump
  :ensure t
  :custom (dumb-jump-prefer-searcher . 'rg)
  :hook (xref-backend-functions . dumb-jump-xref-activate))

(leaf edit-indirect
  :ensure t)

(leaf editorconfig
  :ensure t
  :global-minor-mode t)

(leaf expand-region
  :ensure t
  :bind ("C-=" . er/expand-region))

(leaf flycheck
  :ensure t
  :custom (flycheck-indication-mode . nil)
  :global-minor-mode global-flycheck-mode)

(leaf flycheck-clj-kondo
  :ensure t
  :require t
  :after clojure-mode)

(leaf flycheck-color-mode-line
  :ensure t
  :custom (flycheck-color-mode-line-show-running . nil)
  :after flycheck
  :hook flycheck-mode-hook)

(leaf gcmh
  :ensure t
  :global-minor-mode t)

(leaf git-link
  :ensure t
  :custom (git-link-use-commit . t))

(leaf git-timemachine
  :ensure t)

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
  :bind (("C-c g" . magit-file-dispatch)
         ("C-x g" . magit-status)))

(leaf markdown-mode
  :ensure t)

(leaf minions
  :ensure t
  :custom ((minions-available-modes . nil)
           (minions-mode-line-lighter . "⋯"))
  :global-minor-mode t)

(leaf modus-themes
  :custom ((modus-themes-mode-line . '(borderless))
           (modus-themes-region . '(accented bg-only))
           (modus-themes-subtle-line-numbers . t))
  :init
  (pcase (plist-get (mac-application-state) :appearance)
    ("NSAppearanceNameAqua" (load-theme 'modus-operandi))
    ("NSAppearanceNameDarkAqua" (load-theme 'modus-vivendi)))
  :hook (mac-effective-appearance-change-hook . modus-themes-toggle))

(leaf orderless
  :ensure t
  :custom
  ((completion-category-overrides . '((cider (styles basic))
                                      (file (styles basic partial-completion))))
   (completion-styles . '(orderless basic))
   (orderless-component-separator . " +\\|[-/_\.]")))

(leaf paredit
  :ensure t
  :bind (paredit-mode-map
         ("M-?" . nil))
  :hook (cider-repl-mode-hook
         clojure-mode-hook
         eval-expression-minibuffer-setup-hook
         lisp-data-mode-hook))

(leaf poetry
  :ensure t)

(leaf pragmata-pro
  :config
  (let ((default-font "PragmataPro 12"))
    (add-to-list 'default-frame-alist `(font . ,default-font))
    (set-face-attribute 'default t :font default-font)))

(leaf railwaycat
  :when (display-graphic-p)
  :custom ((mac-command-modifier . nil)
           (mac-option-modifier . 'meta))
  :config
  (global-unset-key [swipe-left])
  (global-unset-key [swipe-right]))

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
  :custom ((vertico-count-format . nil)
           (vertico-cycle . t)
           (vertico-resize . nil))
  :global-minor-mode t)

(leaf vertico-reverse
  :after vertico
  :global-minor-mode t)

(leaf vterm
  :ensure t
  :custom ((vterm-always-compile-module . t)
           (vterm-clear-scrollback-when-clearing . t)))

(leaf vterm-toggle
  :ensure t
  :bind ("C-x RET" . vterm-toggle)
  :custom (vterm-toggle-scope . 'project))

(leaf web-mode
  :ensure t
  :mode ("\\.html?\\'" "\\.jsx?\\'" "\\.tsx?\\'" "\\.css\\'")
  :custom ((web-mode-code-indent-offset . 2)
           (web-mode-css-indent-offset . 2)
           (web-mode-enable-auto-closing . t)
           (web-mode-markup-indent-offset . 2)))

(leaf with-editor
  :ensure t
  :hook (vterm-mode-hook . with-editor-export-editor))

(leaf xref
  :custom ((xref-after-jump-hook . '(recenter))
           (xref-after-return-hook . nil)
           (xref-search-program . 'ripgrep)))

(leaf yaml-mode
  :ensure t)

(leaf zoom
  :ensure t
  :custom (zoom-size . '(0.618 . 0.618))
  :global-minor-mode t)

(provide 'init)

;;; init.el ends here
