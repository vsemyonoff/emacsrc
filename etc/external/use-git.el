;;; use-git.el ---  git mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(with-eval-after-load 'transient
  (setq transient-history-file (vs:emacs/cache "transient.el"))
  )

(if (not (straight-use-package 'magit))
    (warn "===> Can't install 'magit'")

  ;;Triggers
  (require 'magit)

  ;; Keybindings
  (define-key (current-global-map) (kbd "C-x g") #'magit-status)

  ;; Config
  (setq vc-follow-symlinks t
        magit-git-global-arguments
        (nconc magit-git-global-arguments '("-c" "color.ui=false"
                                            "-c" "color.diff=false"))
        )
  )

(if (not (straight-use-package 'git-gutter))
    (warn "===> Can't install 'git-gutter'")

  ;; Triggers
  (add-hook 'vs-emacs-config-hook #'global-git-gutter-mode)

  ;; Config
  (with-eval-after-load 'git-gutter
    (add-hook 'focus-in-hook   #'git-gutter:update-all-windows)
    )

  (if (not (straight-use-package 'git-gutter-fringe))
      (warn "===> Can't install 'git-gutter-fringe'")

    ;; Triggers
    (defun vs:git-gutter-fringe/enable ()
      "Enable git info in fringe only in GUI frames."
      (when (display-graphic-p)
        (require 'git-gutter-fringe)
        )
      )
    (add-hook 'vs-emacs-config-gui-hook #'vs:git-gutter-fringe/enable)

    ;; Config
    (with-eval-after-load 'git-gutter-fringe
      (fringe-helper-define 'git-gutter-fr:added    '(center repeated) "....XXXX")
      (fringe-helper-define 'git-gutter-fr:modified '(center repeated) "....XXXX")
      (fringe-helper-define 'git-gutter-fr:deleted  '(center repeated) "....XXXX")
      )
    )
  )

(if (not (straight-use-package 'gitconfig-mode))
    (warn "===> Can't install 'gitconfig-mode'")

  (require 'gitconfig-mode)
  )

(if (not (straight-use-package 'gitignore-mode))
    (warn "===> Can't install 'gitignore-mode'")

  (require 'gitignore-mode)
  )

(if (not (straight-use-package 'git-timemachine))
    (warn "===> Can't install 'git-timemachine'")

  (defun vs:git-timemachine/header ()
    (setq header-line-format ">>> Back to the future...")
    )
  (add-hook 'git-timemachine-mode-hook #'vs:git-timemachine/header)
  )

(if (not (straight-use-package 'git-link))
    (warn "===> Can't install 'git-link'")
  )

(provide 'use-git)
;;; use-git.el ends here
