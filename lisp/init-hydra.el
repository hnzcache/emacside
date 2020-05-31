;;; init-hydra.el --- Hydra config -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(when (maybe-require-package 'hydra)
  (when (maybe-require-package 'posframe))
  (require 'posframe)
  (setq hydra-hint-display-type 'my/posframe)
  (defun my/hydra-posframe-show (str)
    (posframe-show
     " *hydra-posframe*"
     :string str
     :point (point)
     :internal-border-color "gray50"
     :internal-border-width 2
     :poshandler #'posframe-poshandler-frame-top-center))
  (defun my/hydra-posframe-hide ()
    (posframe-hide " *hydra-posframe*"))
  (setq hydra-hint-display-alist
        (list (list 'my/posframe #'my/hydra-posframe-show #'my/hydra-posframe-hide))
        hydra--work-around-dedicated nil)
  (setq alan--general-lsp-hydra-heads
        '(;; Xref
          ("d" xref-find-definitions "Definitions" :column "Xref")
          ("D" xref-find-definitions-other-window "-> other win")
          ("r" xref-find-references "References")
          ("s" alan/helm-lsp-workspace-symbol-at-point "Helm search")
          ("S" alan/helm-lsp-global-workspace-symbol-at-point "Helm global search")

          ;; Peek
          ("C-d" lsp-ui-peek-find-definitions "Definitions" :column "Peek")
          ("C-r" lsp-ui-peek-find-references "References")
          ("C-i" lsp-ui-peek-find-implementation "Implementation")

          ;; LSP
          ("p" lsp-describe-thing-at-point "Describe at point" :column "LSP")
          ("C-a" lsp-execute-code-action "Execute code action")
          ("R" lsp-rename "Rename")
          ("t" lsp-goto-type-definition "Type definition")
          ("i" lsp-goto-implementation "Implementation")
          ("f" helm-imenu "Filter funcs/classes (Helm)")
          ("C-c" lsp-describe-session "Describe session")

          ;; Flycheck
          ("l" lsp-ui-flycheck-list "List errs/warns/notes" :column "Flycheck"))

        alan--misc-lsp-hydra-heads
        '(;; Misc
          ("q" nil "Cancel" :column "Misc")
          ("b" pop-tag-mark "Back")))

  ;; Create general hydra.
  (eval `(defhydra alan/lsp-hydra (:color blue :hint nil)
           ,@(append
              alan--general-lsp-hydra-heads
              alan--misc-lsp-hydra-heads)))

  (add-hook 'lsp-mode-hook
            (lambda () (local-set-key (kbd "<f2>") 'alan/lsp-hydra/body)))
  )















(provide 'init-hydra)
;;; init-hydra.el ends here
