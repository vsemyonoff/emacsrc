;;; use-git.el ---  git mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'set-config)

(require 'straight)
(require 'delight)

(when (straight-use-package 'magit)
  ;;Triggers
  (require 'magit)
  ;; Keybindings
  (define-key (current-global-map) (kbd "C-x g") #'magit-status)
  ;; Config
  (setq vc-follow-symlinks t
        magit-git-global-arguments
        (nconc magit-git-global-arguments '("-c" "color.ui=false"
                                            "-c" "color.diff=false")))
  (with-eval-after-load 'transient
    (setq transient-history-file (expand-file-name "transient.el" vs-emacs-cache-dir))))

(when (straight-use-package 'git-gutter)
  ;; Triggers
  (defun vs|git-gutter/enable ()
    "Enable `git-gutter-mode' in non-remote buffers."
    (when (and (buffer-file-name)
               (not (file-remote-p (buffer-file-name))))
      (git-gutter-mode)))
  (add-hook 'conf-mode-hook  #'vs|git-gutter/enable         )
  (add-hook 'prog-mode-hook  #'vs|git-gutter/enable         )
  (add-hook 'text-mode-hook  #'vs|git-gutter/enable         )
  ;; Delight
  (delight 'git-gutter-mode nil 'git-gutter)
  ;; Config
  (with-eval-after-load 'git-gutter
    (add-hook 'focus-in-hook   #'git-gutter:update-all-windows))

  (when (straight-use-package 'git-gutter-fringe)
    ;; Triggers
    (defun vs|git-gutter-fringe/enable ()
      "Enable git info in fringe only in GUI frames."
      (when (display-graphic-p)
        (require 'git-gutter-fringe)))
    (add-hook 'vs-emacs-config-gui-hook #'vs|git-gutter-fringe/enable)
    ;; Config
    (with-eval-after-load 'git-gutter-fringe
      (fringe-helper-define 'git-gutter-fr:added '(center repeated) "....XXXX")
      (fringe-helper-define 'git-gutter-fr:modified '(center repeated) "....XXXX")
      (fringe-helper-define 'git-gutter-fr:deleted '(center repeated) "....XXXX"))))

(when (straight-use-package 'gitconfig-mode)
  ;; Triggers
  (require 'gitconfig-mode))

(when (straight-use-package 'gitignore-mode)
  ;; Triggers
  (require 'gitignore-mode))

(straight-use-package 'git-timemachine)

(straight-use-package 'git-link)

(provide 'use-git)
;;; use-git.el ends here
