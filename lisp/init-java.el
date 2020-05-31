;;; init-java.el --- LSP config -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(when (maybe-require-package 'lsp-java)
  (require 'lsp-java)
  (add-hook 'java-mode-hook #'lsp))

(when (maybe-require-package 'dap-mode)
  (after-load 'lsp-mode
    (setq dap-mode t
          dap-ui-mode t)))


(provide 'init-java)
;;; init-java.el ends here
