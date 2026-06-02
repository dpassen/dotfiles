;;; early-init.el --- Early Initialization code ;;; -*- lexical-binding: t;-*-
;;; Commentary:

;;; Code:

(setq frame-inhibit-implied-resize t
      menu-bar-mode nil
      mode-line-format nil
      scroll-bar-mode nil
      tool-bar-mode nil)

(push '(menu-bar-lines . 0) default-frame-alist)
(push '(ns-transparent-titlebar . t) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(push '(visibility . nil) initial-frame-alist)

(add-hook 'after-init-hook #'make-frame-visible)

;; Local Variables:
;; no-byte-compile: t
;; no-native-compile: t
;; no-update-autoloads: t
;; End:

;;; early-init.el ends here
