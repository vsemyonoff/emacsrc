;;; use-spaceline.el ---  mode line settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package spaceline
  :commands spaceline-emacs-theme
  :hook (vs-emacs-config . spaceline-emacs-theme))

(provide 'use-spaceline)
;;; use-spaceline.el ends here
