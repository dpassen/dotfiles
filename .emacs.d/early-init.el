;;; early-init.el --- Early Initialization code ;;; -*- lexical-binding: t;-*-
;;; Commentary:

;;; Code:

(setq package-enable-at-startup nil)

(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

(setq frame-inhibit-implied-resize t)

(let ((default-gc-threshold gc-cons-threshold)
      (default-gc-percentage gc-cons-percentage)
      (default-file-name-handler-alist file-name-handler-alist))
  (setq gc-cons-threshold most-positive-fixnum
        gc-cons-percentage 0.8
        file-name-handler-alist nil)
  (add-hook 'after-init-hook
            (lambda ()
              (setq gc-cons-threshold default-gc-threshold
                    gc-cons-percentage default-gc-percentage
                    file-name-handler-alist default-file-name-handler-alist))))

(provide 'early-init)

;; Local Variables:
;; no-byte-compile: t
;; no-native-compile: t
;; no-update-autoloads: t
;; End:

;;; early-init.el ends here
