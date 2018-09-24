;;; use-git.el ---  git mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package gitconfig-mode
  :mode "/\\.?git/?config$"
  :mode "/\\.gitmodules$")


(use-package gitignore-mode
  :mode "/\\.gitignore$")


(use-package git-gutter :delight
  :commands git-gutter-mode
  :hook
  ((focus-in  . git-gutter:update-all-windows)
   (conf-mode . vs|git-gutter/enable         )
   (prog-mode . vs|git-gutter/enable         )
   (text-mode . vs|git-gutter/enable         ))

  :init
  (defun vs|git-gutter/enable ()
    "Enable `git-gutter-mode' in non-remote buffers."
    (when (and (buffer-file-name)
               (not (file-remote-p (buffer-file-name))))
      (git-gutter-mode))))


(use-package git-gutter-fringe
  :config
  (progn
    (setq-default fringes-outside-margins t)

    (fringe-helper-define 'git-gutter-fr:added '(center repeated)
      "....XXXX")
    (fringe-helper-define 'git-gutter-fr:modified '(center repeated)
      "....XXXX")
    (fringe-helper-define 'git-gutter-fr:deleted '(center repeated)
      "....XXXX"))

  :hook ((vs-emacs-config-gui  . vs|git-gutter-fringe/enable))

  :init
  (defun vs|git-gutter-fringe/enable ()
    (when (display-graphic-p)
      (require 'git-gutter-fringe))))


(use-package git-timemachine
  :commands (git-timemachine git-timemachine-toggle))


(use-package magit
  :commands (magit-status magit-blame magit-git-success)
  :general ("C-x g" 'magit-status))


(use-package git-link
  :commands (git-link git-link-commit git-link-homepage))


(provide 'use-git)
;;; use-git.el ends here
