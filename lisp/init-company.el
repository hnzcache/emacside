;;; init-company.el --- Completion with company -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; WAITING: haskell-mode sets tags-table-list globally, breaks tags-completion-at-point-function
;; TODO Default sort order should place [a-z] before punctuation

(setq tab-always-indent 'complete)
(add-to-list 'completion-styles 'initials t)

(when (maybe-require-package 'company)
  (setq company-idle-delay 0

        company-minimum-prefix-length 3

        company-require-match nil

        company-dabbrev-ignore-case nil

        company-show-numbers t
        )
  (add-hook 'after-init-hook 'global-company-mode)
  (after-load 'company
    (dolist (backend '(company-eclim company-semantic))
      (delq backend company-backends))

    (when (maybe-require-package 'company-irony))
    (when (maybe-require-package 'company-irony-c-headers)
      (add-to-list 'company-backends '(company-irony company-irony-c-headers )))

    (when (maybe-require-package 'company-c-headers)
      (setq company-c-headers-path-system '(
                                            "/usr/include/c++/10.0.1"
                          	            "/usr/include/c++/10.0.1/backward"
                                            "/usr/lib/gcc/x86_64-pc-linux-gnu/10.0.1/include"
                                            "/usr/local/include"
                                            "/usr/lib/gcc/x86_64-pc-linux-gnu/10.0.1/include-fixed"
                                            "/usr/include/x86_64-pc-linux-gnu"
                                            "/usr/include"))
      (add-to-list 'company-backends 'company-c-headers))

    (diminish 'company-mode)
    (define-key company-mode-map (kbd "M-/") 'company-complete)
    (define-key company-active-map (kbd "M-/") 'company-other-backend)
    (define-key company-active-map (kbd "C-n") 'company-select-next)
    (define-key company-active-map (kbd "C-p") 'company-select-previous)
    (setq-default company-dabbrev-other-buffers 'all
                  company-tooltip-align-annotations t))
  (global-set-key (kbd "M-C-/") 'company-complete)

  (when (maybe-require-package 'company-quickhelp)
    (add-hook 'after-init-hook 'company-quickhelp-mode)))

;; Suspend page-break-lines-mode while company menu is active
;; (see https://github.com/company-mode/company-mode/issues/416)
(after-load 'company
  (after-load 'page-break-lines
    (defvar-local sanityinc/page-break-lines-on-p nil)

    (defun sanityinc/page-break-lines-disable (&rest ignore)
      (when (setq sanityinc/page-break-lines-on-p (bound-and-true-p page-break-lines-mode))
        (page-break-lines-mode -1)))

    (defun sanityinc/page-break-lines-maybe-reenable (&rest ignore)
      (when sanityinc/page-break-lines-on-p
        (page-break-lines-mode 1)))

    (add-hook 'company-completion-started-hook 'sanityinc/page-break-lines-disable)
    (add-hook 'company-after-completion-hook 'sanityinc/page-break-lines-maybe-reenable)))



(provide 'init-company)
;;; init-company.el ends here
