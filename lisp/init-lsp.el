;;; init-lsp.el --- LSP config -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; (when (maybe-require-package 'ccls)
;;   (require 'ccls)
;;   (setq ccls-executable "/snap/bin/ccls"))
(when (maybe-require-package 'ccls)
  (require 'ccls)
  (setq ccls-executable "/usr/bin/ccls")
  (setq lsp-prefer-flymake nil)
  (setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-cppcheck c/c++-gcc)))
(when (maybe-require-package 'lsp-mode)
  (setq lsp-java-server-install-dir
        "~/.emacs.d/jdtls/")
  (setq lsp-keymap-prefix "<f4>")

  (require 'lsp-mode)
  (setq lsp-message-project-root-warning t
        lsp-prefer-flymake nil
        lsp-restart 'ignore
        lsp-eldoc-hook nil
        lsp-eldoc-enable-hover nil
        lsp-auto-configure nil
        lsp-enable-symbol-highlighting nil)
  (add-hook 'c++-mode-hook #'lsp)
  (add-hook 'c-mode-hook #'lsp)
  (add-hook 'python-mode-hook #'lsp))



(when (maybe-require-package 'lsp-ui)
  ;; (add-hook 'c-mode-hook 'lsp-ui-mode)
  ;; (add-hook 'c++-mode-hook 'lsp-ui-mode)
  ;; (add-hook 'python-mode-hook 'lsp-ui-mode)
  (define-key lsp-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)

  (add-hook 'lsp-mode-hook 'lsp-ui-mode)



  (setq lsp-ui-doc-enable t
        lsp-ui-doc-use-childframe t
        lsp-ui-doc-position 'top
        lsp-ui-doc-include-signature t
        lsp-ui-sideline-enable nil
        lsp-ui-flycheck-enable t
        lsp-ui-flycheck-list-position 'right
        lsp-ui-flycheck-live-reporting t
        lsp-ui-peek-enable t
        lsp-ui-peek-always-show t
        lsp-ui-peek-list-width 60
        lsp-ui-peek-peek-height 25)
  )


(when (maybe-require-package 'company-lsp)
  (after-load 'company
    (setq        company-lsp-enable-recompletion t
                 company-lsp-async t
                 company-lsp-cache-candidates 'auto
                 company-lsp-match-candidate-predicate 'company-lsp-match-candidate-prefix)
    (push 'company-lsp company-backends)))


(when (maybe-require-package 'lsp-ivy)
  ;;  (define-key company-mode-map (kbd "M-/") 'company-complete)
  (define-key lsp-mode-map [remap xref-find-apropos] #'lsp-ivy-workspace-symbol))



(defvar lsp-language-id-configuration
  '(...
    (python-mode . "python")
;;    (java-mode . "java")
    ...))
;; if you are adding the support for your language server in separate repo use
;; (add-to-list 'lsp-language-id-configuration '(python-mode . "python"))

(lsp-register-client
 (make-lsp-client :new-connection (lsp-stdio-connection "pyls")
                  :major-modes '(python-mode)
                  :server-id 'pyls))
;; (lsp-register-client
;;  (make-lsp-client :new-connection (lsp-stdio-connection "jdtls")
;;                   :major-modes '(java-mode)
;;                   :server-id 'jdtls))







(provide 'init-lsp)
;;; init-lsp.el ends here
