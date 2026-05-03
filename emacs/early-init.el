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

(let ((default-file-name-handler-alist file-name-handler-alist)
      (default-gc-cons-percentage gc-cons-percentage)
      (default-gc-cons-threshold gc-cons-threshold))
  (setq file-name-handler-alist nil
        gc-cons-percentage 0.8
        gc-cons-threshold most-positive-fixnum)
  (add-hook 'after-init-hook
            (lambda ()
              (setq file-name-handler-alist default-file-name-handler-alist
                    gc-cons-percentage default-gc-cons-percentage
                    gc-cons-threshold default-gc-cons-threshold)
              (make-frame-visible))))

;; Local Variables:
;; no-byte-compile: t
;; no-native-compile: t
;; no-update-autoloads: t
;; End:

;;; early-init.el ends here
