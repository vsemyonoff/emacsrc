;;; use-hes.el ---  highlight escape sequences minor mode. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package highlight-escape-sequences
  :hook ((conf-mode . hes-mode)
         (prog-mode . hes-mode))
  )

(provide 'use-hes)
;;; use-hes.el ends here
