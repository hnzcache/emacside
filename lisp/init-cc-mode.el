;;; init-cc-mode.el --- C/C++ config -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:





(when (maybe-require-package 'google-c-style)
  (add-hook 'c-mode-common-hook 'google-set-c-style)
  (add-hook 'c-mode-common-hook 'google-make-newline-indent))

(when (maybe-require-package 'clang-format)
  (require 'clang-format)
  (defun clang-format-on-save ()
    (add-hook 'before-save-hook #'clang-format-buffer nil 'local))
  (add-hook 'c++-mode-hook 'clang-format-on-save)
  (add-hook 'c-mode-hook 'clang-format-on-save))
;; (when (maybe-require-package 'ggtags)
;;   (add-hook 'c-mode-common-hook
;;             (lambda ()
;;               (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
;;                 (ggtags-mode 1)))))


(when (maybe-require-package ' irony)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
  )

(when (maybe-require-package 'irony-eldoc)
  (add-hook 'irony-mode-hook #'irony-eldoc))














(provide 'init-cc-mode)
;;; init-cc-mode.el ends here
