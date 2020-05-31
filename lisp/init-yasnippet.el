;;; init-yasnippet.el --- Measure startup and require times -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:



(when (maybe-require-package 'yasnippet)
  (when (maybe-require-package 'yasnippet-snippets))
  (add-hook 'prog-mode-hook #'yas-minor-mode))




















(provide 'init-yasnippet)
;;; init-yasnippet.el ends here
