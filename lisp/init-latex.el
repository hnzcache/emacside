;;; init-latex.el --- LaTeX config -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; Just a simple config

(when (maybe-require-package 'auctex)
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq-default TeX-master nil)
  (add-hook 'LaTeX-mode-hook
            (lambda ()
              (rainbow-delimiters-mode)
              (turn-on-reftex)
              (setq TeX-PDF-mode t)
              (setq TeX-source-correlate-method 'synctex)
              (setq TeX-source-correlate-start-server t))))

(when (maybe-require-package 'reftex)
  (setq reftex-cite-prompt-optional-args t)
  (reftex-isearch-minor-mode)
  (setq reftex-plug-into-AUCTeX t))


(when (maybe-require-package 'cdlatex)
  (setq cdlatex-simplify-sub-super-scripts nil
        cdlatex-paired-parens "$[{("
        cdlatex-sub-super-scripts-outside-math-mode nil
        cdlatex-insert-auto-labels-in-env-templates nil)
  (add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)
  (add-hook 'org-mode-hook 'turn-on-cdlatex))


(when (maybe-require-package 'pdf-tools)
  (pdf-tools-install)
  (when (maybe-require-package '  pdf-view-restore)
    (after-load 'pdf-tools
      (add-hook 'pdf-view-mode-hook 'pdf-view-restore-mode)))
  (setq mouse-wheel-follow-mouse t)
  (setq pdf-view-resize-factor 1.10)
  (setq TeX-view-program-selection '((output-pdf "pdf-tools"))
        TeX-source-correlate-start-server t)
  (setq TeX-view-program-list '(("pdf-tools" "TeX-pdf-tools-sync-view"))))

(add-hook 'TeX-after-TeX-LaTeX-command-finished-hook
          #'TeX-revert-document-buffer)




(provide 'init-latex)
;;; init-latex.el ends here
