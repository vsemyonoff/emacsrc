;;; use-ivy.el ---  helper framework. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'set-config)
(require 'straight)

(straight-use-package 'hydra)

(straight-use-package 'counsel)
;; Triggers
(add-hook 'vs-emacs-config-hook #'ivy-mode)
;; Keybindings
(define-key (current-global-map) (kbd "C-r") #'swiper)
(define-key (current-global-map) (kbd "C-s") #'swiper)
;; Delight
(delight '((counsel-mode nil counsel)
           (ivy-mode     nil ivy    )))
;; Config
(with-eval-after-load 'ivy
  (warn "===> TODO: ivy modes for gitlab, passwords")
  (setq ivy-count-format            "[%d/%d]: "
        ivy-extra-directories       nil
        ivy-format-function         'vs|ivy/custom-format
        ivy-ignore-buffers          '("\\`\\( \\|\\*lsp\\|treemacs\\)")
        ivy-re-builders-alist       '((t . ivy--regex-ignore-order))
        ivy-use-selectable-prompt   t
        ivy-use-virtual-buffers     t
        ivy-virtual-abbreviate      'full)
  (defun vs|ivy/custom-format (cands)
    "Set custom `ivy' format."
    (ivy--format-function-generic
     (lambda (str)
       (concat " => " (ivy--add-face str 'ivy-current-match)))
     (lambda (str)
       (concat "    " str))
     cands
     "\n"))
  (defun vs|ivy/update-window-height ()
    "Set `ivy' window height to 25% from current frame height."
    (setq ivy-height `,(floor (frame-height) 4)))
  (add-hook 'window-configuration-change  #'vs|ivy/update-window-height)
  (add-hook 'ivy-mode-hook                #'counsel-mode))

(with-eval-after-load 'ivy
  (straight-use-package 'ivy-hydra)
  ;; Triggers
  (require 'ivy-hydra))

(with-eval-after-load 'projectile
  (straight-use-package 'counsel-projectile)
  (add-hook 'counsel-mode-hook #'counsel-projectile-mode))

(straight-use-package 'ivy-rich)
;; Triggers
(add-hook 'counsel-mode-hook #'ivy-rich-mode)
;; Config
(with-eval-after-load 'ivy-rich
  (warn "===> TODO: setup ivy-rich kill buffer")
  (setq ivy-rich-path-style 'full))

(provide 'use-ivy)
;;; use-ivy.el ends here
