;;; init-exec-path.el --- Set up exec-path to help Emacs find programs  -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(setenv "PATH"
        (concat
         "/usr/local/texlive/2019/bin/x86_64-linux" ":"
         "/usr/bin" ":"
         "/usr/local/bin" ":"
         "/usr/lib/jvm/jdk-13.0.2/bin" ":"
         "/home/alan/.local/bin" ":"
         (getenv  "PATH")
         )
        )
(let (
      (mypaths
       '(
         "/usr/local/texlive/2019/bin/x86_64-linux"
         "/usr/bin"
         "/usr/local/bin"

         ))

      )
  (setq exec-path (append exec-path mypaths) )
  )

(provide 'init-exec-path)
;;; init-exec-path.el ends here
