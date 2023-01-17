;;; init.el --- Initialization code ;;; -*- lexical-binding: t;-*-
;;; Commentary:

;;; Code:

(eval-and-compile
  (customize-set-variable
   'package-archives '(("melpa" . "https://melpa.org/packages/")
                       ("gnu" . "https://elpa.gnu.org/packages/")
                       ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :config (leaf-keywords-init)))

(leaf emacs
  :custom ((indent-tabs-mode . nil)
           (inhibit-startup-screen . t)
           (load-prefer-newer . t)
           (ring-bell-function . 'ignore)
           (use-short-answers . t))
  :setq ((frame-title-format . '("%b - emacs"))
         (kill-buffer-query-functions . nil)
         (message-truncate-lines . t)))

(leaf emacs-mac
  :when (eq system-type 'darwin)
  :custom ((mac-command-modifier . nil)
           (mac-option-modifier . 'meta))
  :config
  (global-unset-key [swipe-left])
  (global-unset-key [swipe-right]))

(leaf apheleia
  :ensure t
  :global-minor-mode apheleia-global-mode)

(leaf autorevert
  :custom (auto-revert-verbose . nil)
  :global-minor-mode global-auto-revert-mode)

(leaf cape
  :ensure t
  :bind (("C-c p p" . completion-at-point)
         ("C-c p d" . cape-dabbrev)
         ("C-c p f" . cape-file)
         ("C-c p i" . cape-ispell)
         ("C-c p k" . cape-keyword)
         ("C-c p s" . cape-symbol)))

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
  :custom (corfu-cycle . t)
  :global-minor-mode global-corfu-mode)

(leaf cus-edit
  :custom `(custom-file . ,(expand-file-name "custom.el" user-emacs-directory))
  :config (load custom-file 'noerror))

(leaf default-text-scale
  :ensure t
  :global-minor-mode t)

(leaf dired
  :custom (dired-kill-when-opening-new-dired-buffer . t))

(leaf dumb-jump
  :ensure t
  :custom (dumb-jump-force-searcher . 'rg)
  :hook (xref-backend-functions . dumb-jump-xref-activate))

(leaf edit-indirect
  :ensure t)

(leaf editorconfig
  :ensure t
  :global-minor-mode t)

(leaf envrc
  :ensure t
  :bind (envrc-mode-map
         ("C-c e" . envrc-command-map))
  :global-minor-mode envrc-global-mode)

(leaf exec-path-from-shell
  :ensure t
  :when (memq window-system '(mac ns x))
  :config (exec-path-from-shell-initialize))

(leaf expand-region
  :ensure t
  :custom (expand-region-show-usage-message . nil)
  :bind ("C-=" . er/expand-region))

(leaf files
  :custom ((confirm-kill-processes . nil)
           (require-final-newline . t)))

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

(leaf frame
  :config
  (set-frame-font "PragmataPro Liga 12" nil t))

(leaf git-link
  :ensure t
  :custom (git-link-use-commit . t))

(leaf git-timemachine
  :ensure t)

(leaf hideshow
  :hook (prog-mode-hook . hs-minor-mode))

(leaf initial-size
  :when (display-graphic-p)
  :config
  (add-to-list 'default-frame-alist '(height . 50))
  (add-to-list 'default-frame-alist '(width . 120)))

(leaf ligature
  :ensure t
  :config
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
  :global-minor-mode global-ligature-mode)

(leaf magit
  :ensure t
  :custom ((magit-define-global-key-bindings . nil)
           (magit-diff-refine-hunk . t))
  :bind (("C-c g" . magit-file-dispatch)
         ("C-x g" . magit-dispatch)))

(leaf marginalia
  :ensure t
  :after vertico
  :global-minor-mode t)

(leaf markdown-mode
  :ensure t)

(leaf minions
  :ensure t
  :custom ((minions-available-modes . nil)
           (minions-mode-line-lighter . "⋯"))
  :global-minor-mode t)

(leaf misc
  :bind ("M-z" . zap-up-to-char))

(leaf modus-themes
  :custom ((modus-themes-italic-constructs . t)
           (modus-themes-mode-line . '(borderless))
           (modus-themes-region . '(accented bg-only))
           (modus-themes-subtle-line-numbers . t))
  :init
  (let ((initial-theme (pcase (plist-get (mac-application-state) :appearance)
                         ("NSAppearanceNameAqua" 'modus-operandi)
                         ("NSAppearanceNameDarkAqua" 'modus-vivendi)
                         (_default 'modus-operandi))))
    (load-theme initial-theme))
  :hook (mac-effective-appearance-change-hook . modus-themes-toggle))

(leaf orderless
  :ensure t
  :custom
  ((completion-category-overrides . '((cider (styles basic))
                                      (file (styles basic partial-completion))))
   (completion-styles . '(orderless basic))
   (orderless-component-separator . " +\\|[-/_\.]")))

(leaf paren
  :custom (show-paren-mode . nil))

(leaf projectile
  :ensure t
  :bind (projectile-mode-map
         ("C-x p" . projectile-command-map))
  :global-minor-mode t)

(leaf restclient
  :ensure t)

(leaf rg
  :ensure t)

(leaf savehist
  :global-minor-mode t)

(leaf saveplace
  :global-minor-mode save-place-mode)

(leaf simple
  :custom ((async-shell-command-buffer . 'new-buffer)
           (column-number-mode . t)
           (read-quoted-char-radix . 16)))

(leaf smartparens
  :ensure t
  :require smartparens-config
  :custom (sp-highlight-pair-overlay . nil)
  :config (sp-use-smartparens-bindings)
  :global-minor-mode smartparens-global-strict-mode)

(leaf subword
  :global-minor-mode global-subword-mode)

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
  :bind ("C-x RET" . vterm-other-window)
  :custom ((vterm-always-compile-module . t)
           (vterm-clear-scrollback-when-clearing . t)))

(leaf web-mode
  :ensure t
  :mode ("\\.html?\\'" "\\.jsx?\\'" "\\.tsx?\\'" "\\.css\\'" "\\.json\\'")
  :custom ((web-mode-code-indent-offset . 2)
           (web-mode-css-indent-offset . 2)
           (web-mode-enable-auto-closing . t)
           (web-mode-markup-indent-offset . 2)))

(leaf with-editor
  :ensure t
  :hook (vterm-mode-hook . with-editor-export-editor))

(leaf xref
  :custom
  ((xref-after-jump-hook . '(recenter))
   (xref-after-return-hook . nil)
   (xref-search-program . 'ripgrep)
   (xref-show-definitions-function . #'xref-show-definitions-completing-read))
  :defun xref-show-definitions-completing-read)

(leaf yaml-mode
  :ensure t)

(leaf zoom
  :ensure t
  :custom (zoom-size . '(0.618 . 0.618))
  :global-minor-mode t)

(provide 'init)

;;; init.el ends here
