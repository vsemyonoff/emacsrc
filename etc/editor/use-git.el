;;; use-git.el ---  git mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package gitconfig-mode
  :mode "/\\.?git/?config$"
  :mode "/\\.gitmodules$")


(use-package gitignore-mode
  :mode "/\\.gitignore$")


(use-package git-gutter
  :commands git-gutter-mode

  :hook
  ((focus-in  . git-gutter:update-all-windows)
   (conf-mode . vs|git-gutter/mode-on        )
   (prog-mode . vs|git-gutter/mode-on        )
   (text-mode . vs|git-gutter/mode-on        ))

  :init
  (defun vs|git-gutter/mode-on ()
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
    (fringe-helper-define 'git-gutter-fr:deleted 'bottom
      ".......X"
      "......XX"
      ".....XXX"
      "....XXXX"))

  :hook ((vs-emacs-config-gui  . vs|git-gutter/fringe-on))

  :init
  (defun vs|git-gutter/fringe-on ()
    (when (display-graphic-p)
      (require 'git-gutter-fringe))))


(use-package git-timemachine
  :commands (git-timemachine git-timemachine-toggle))


(use-package magit
  :commands (magit-status magit-blame))


(use-package git-link
  :commands (git-link git-link-commit git-link-homepage))


(provide 'use-git)
;;; set-git.el ends here
