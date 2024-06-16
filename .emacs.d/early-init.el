;;; early-init.el --- Early Initialization code ;;; -*- lexical-binding: t;-*-
;;; Commentary:

;;; Code:

(setq frame-inhibit-implied-resize t
      mode-line-format nil
      package-enable-at-startup nil)

(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

(setq menu-bar-mode nil
      tool-bar-mode nil
      scroll-bar-mode nil)

(let ((default-file-name-handler-alist file-name-handler-alist)
      (default-gc-percentage gc-cons-percentage)
      (default-gc-threshold gc-cons-threshold))
  (setq gc-cons-threshold most-positive-fixnum
        gc-cons-percentage 0.8
        file-name-handler-alist nil)
  (add-hook 'after-init-hook
            (lambda ()
              (setq file-name-handler-alist default-file-name-handler-alist
                    gc-cons-percentage default-gc-percentage
                    gc-cons-threshold default-gc-threshold))))

;; Local Variables:
;; no-byte-compile: t
;; no-native-compile: t
;; no-update-autoloads: t
;; End:

;;; early-init.el ends here
