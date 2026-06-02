;;; early-init.el --- Early Initialization code ;;; -*- lexical-binding: t;-*-
;;; Commentary:

;;; Code:

(setopt scroll-bar-mode nil)
(setopt tool-bar-mode nil)

(push '(ns-transparent-titlebar . t) default-frame-alist)
(push '(visibility . nil) initial-frame-alist)

(add-hook 'after-init-hook #'make-frame-visible)

;; Local Variables:
;; no-byte-compile: t
;; no-native-compile: t
;; no-update-autoloads: t
;; End:

;;; early-init.el ends here
